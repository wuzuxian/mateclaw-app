import 'dart:io';

void main(List<String> args) {
  final stagedOnly = args.contains('--staged');
  final files = stagedOnly ? _stagedFiles() : _allTrackedFiles();

  if (stagedOnly && files.isEmpty) {
    stdout.writeln('No staged files to check.');
    return;
  }

  final violations = <_Violation>[];

  if (!stagedOnly || files.contains('pubspec.yaml')) {
    violations.addAll(_checkPubspec());
  }

  if (!stagedOnly || files.contains('l10n.yaml')) {
    violations.addAll(_checkL10nYaml());
  }

  for (final file in files.where((file) => file.endsWith('.dart'))) {
    if (!File(file).existsSync()) {
      continue;
    }

    violations.addAll(_checkDartFile(file));
  }

  if (violations.isEmpty) {
    stdout.writeln('Mateclaw project rules passed.');
    return;
  }

  stderr.writeln('Mateclaw project rules failed:');
  for (final violation in violations) {
    stderr.writeln('${violation.file}:${violation.line}: ${violation.message}');
  }

  exitCode = 1;
}

List<String> _stagedFiles() {
  final result = Process.runSync('git', [
    'diff',
    '--cached',
    '--name-only',
    '--diff-filter=ACMR',
  ]);

  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    exit(result.exitCode);
  }

  return _splitFileList(result.stdout as String);
}

List<String> _allTrackedFiles() {
  final tracked = Process.runSync('git', ['ls-files']);

  if (tracked.exitCode != 0) {
    stderr.write(tracked.stderr);
    exit(tracked.exitCode);
  }

  final untracked = Process.runSync('git', [
    'ls-files',
    '--others',
    '--exclude-standard',
  ]);

  if (untracked.exitCode != 0) {
    stderr.write(untracked.stderr);
    exit(untracked.exitCode);
  }

  return {
    ..._splitFileList(tracked.stdout as String),
    ..._splitFileList(untracked.stdout as String),
  }.toList(growable: false)..sort();
}

List<String> _splitFileList(String output) {
  return output
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList(growable: false);
}

List<_Violation> _checkPubspec() {
  final file = File('pubspec.yaml');
  if (!file.existsSync()) {
    return const [];
  }

  final content = file.readAsStringSync();
  final requiredEntries = {
    'dependencies': [
      'flutter_localizations:',
      'go_router:',
      'intl:',
      'provider:',
    ],
    'dev_dependencies': ['custom_lint:', 'mateclaw_lints:'],
  };

  final violations = <_Violation>[];
  for (final entry in requiredEntries.entries) {
    for (final dependency in entry.value) {
      if (!content.contains(
        RegExp('^\\s{2}${RegExp.escape(dependency)}', multiLine: true),
      )) {
        violations.add(
          _Violation(
            'pubspec.yaml',
            1,
            'Missing ${entry.key} entry `$dependency` required by project conventions.',
          ),
        );
      }
    }
  }

  return violations;
}

List<_Violation> _checkL10nYaml() {
  final file = File('l10n.yaml');
  if (!file.existsSync()) {
    return const [];
  }

  final content = file.readAsStringSync();
  final requiredKeys = [
    'arb-dir:',
    'template-arb-file:',
    'output-localization-file:',
  ];

  return [
    for (final key in requiredKeys)
      if (!content.contains(RegExp('^$key', multiLine: true)))
        _Violation(
          'l10n.yaml',
          1,
          'Missing `$key` required by gen_l10n conventions.',
        ),
  ];
}

List<_Violation> _checkDartFile(String path) {
  final normalized = path.replaceAll('\\', '/');
  if (!normalized.startsWith('lib/') || _isGeneratedOrL10nFile(normalized)) {
    return const [];
  }

  final content = File(path).readAsStringSync();
  final lines = content.split('\n');
  final violations = <_Violation>[];

  _scanLines(
    path: path,
    lines: lines,
    pattern: RegExp(
      r'\bNavigator\.(push|pushNamed|pushReplacement|pushReplacementNamed|popAndPushNamed|replace|replaceRouteBelow)\b',
    ),
    message: 'Use GoRouter instead of imperative Navigator APIs.',
    violations: violations,
  );

  _scanLines(
    path: path,
    lines: lines,
    pattern: RegExp(
      r'''\b\w+\.(go|push|replace|pushReplacement)\(\s*r?['"]\/''',
    ),
    message:
        'Use AppRoutes constants or named routes instead of hardcoded route paths.',
    violations: violations,
  );

  if (_isViewModelFile(normalized)) {
    _scanLines(
      path: path,
      lines: lines,
      pattern: RegExp(
        r'''^\s*import\s+['"](package:flutter/material\.dart|dart:ui)['"]''',
      ),
      message:
          'ViewModel must not import UI libraries; use flutter/foundation.dart when needed.',
      violations: violations,
    );

    _scanLines(
      path: path,
      lines: lines,
      pattern: RegExp(r'\bBuildContext\b'),
      message: 'ViewModel must not depend on BuildContext.',
      violations: violations,
    );
  }

  if (_isViewFile(normalized)) {
    _scanLines(
      path: path,
      lines: lines,
      pattern: RegExp(
        r'''^\s*import\s+['"].*(/(data|services|repositories)/).*(service|repository|api|database).*['"]''',
        caseSensitive: false,
      ),
      message:
          'View layer must not import Service or Repository classes directly.',
      violations: violations,
    );
  }

  _scanLines(
    path: path,
    lines: lines,
    pattern: RegExp(
      r'''(\bText\(\s*r?['"][^'"]*[A-Za-z\u4e00-\u9fff][^'"]*['"]|\b(tooltip|semanticsLabel|label|hintText|helperText|errorText):\s*r?['"][^'"]*[A-Za-z\u4e00-\u9fff][^'"]*['"])''',
    ),
    message:
        'User-visible text must come from AppLocalizations or context.l10n.',
    violations: violations,
  );

  return violations;
}

void _scanLines({
  required String path,
  required List<String> lines,
  required RegExp pattern,
  required String message,
  required List<_Violation> violations,
}) {
  for (var index = 0; index < lines.length; index += 1) {
    final line = lines[index];
    if (line.trimLeft().startsWith('//')) {
      continue;
    }

    if (pattern.hasMatch(line)) {
      violations.add(_Violation(path, index + 1, message));
    }
  }
}

bool _isViewModelFile(String path) {
  final lower = path.toLowerCase();
  return lower.contains('/viewmodel/') ||
      lower.endsWith('_view_model.dart') ||
      lower.endsWith('_viewmodel.dart');
}

bool _isViewFile(String path) {
  final lower = path.toLowerCase();
  return lower.contains('/view/') ||
      lower.endsWith('_page.dart') ||
      lower.endsWith('_screen.dart');
}

bool _isGeneratedOrL10nFile(String path) {
  final lower = path.toLowerCase();
  return lower.startsWith('lib/l10n/') ||
      lower.endsWith('.g.dart') ||
      lower.endsWith('.freezed.dart') ||
      lower.endsWith('.gen.dart');
}

class _Violation {
  const _Violation(this.file, this.line, this.message);

  final String file;
  final int line;
  final String message;
}
