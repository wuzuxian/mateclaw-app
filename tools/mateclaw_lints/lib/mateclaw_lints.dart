// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

PluginBase createPlugin() => _MateclawLintPlugin();

class _MateclawLintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => const [
    AvoidImperativeNavigatorRule(),
    AvoidHardcodedGoRouterPathRule(),
    AvoidMaterialInViewModelRule(),
    AvoidBuildContextInViewModelRule(),
    AvoidDataLayerImportInViewRule(),
    AvoidHardcodedVisibleTextRule(),
  ];
}

class AvoidImperativeNavigatorRule extends DartLintRule {
  const AvoidImperativeNavigatorRule()
    : super(
        code: const LintCode(
          name: 'mateclaw_avoid_imperative_navigator',
          problemMessage: 'Use GoRouter instead of imperative Navigator APIs.',
        ),
      );

  static const _blockedMethods = {
    'push',
    'pushNamed',
    'pushReplacement',
    'pushReplacementNamed',
    'popAndPushNamed',
    'replace',
    'replaceRouteBelow',
  };

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    if (!_isProjectLibFile(resolver.path)) {
      return;
    }

    context.registry.addMethodInvocation((node) {
      final target = node.target;
      if (target is! SimpleIdentifier || target.name != 'Navigator') {
        return;
      }

      if (_blockedMethods.contains(node.methodName.name)) {
        reporter.atNode(node.methodName, code);
      }
    });
  }
}

class AvoidHardcodedGoRouterPathRule extends DartLintRule {
  const AvoidHardcodedGoRouterPathRule()
    : super(
        code: const LintCode(
          name: 'mateclaw_avoid_hardcoded_go_router_path',
          problemMessage:
              'Use AppRoutes constants or named routes instead of hardcoded route paths.',
        ),
      );

  static const _goRouterMethods = {'go', 'push', 'replace', 'pushReplacement'};

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    if (!_isProjectLibFile(resolver.path)) {
      return;
    }

    context.registry.addMethodInvocation((node) {
      if (!_goRouterMethods.contains(node.methodName.name)) {
        return;
      }

      final arguments = node.argumentList.arguments;
      if (arguments.isEmpty) {
        return;
      }

      final firstArgument = arguments.first;
      if (firstArgument is SimpleStringLiteral &&
          firstArgument.value.startsWith('/')) {
        reporter.atNode(firstArgument, code);
      }
    });
  }
}

class AvoidMaterialInViewModelRule extends DartLintRule {
  const AvoidMaterialInViewModelRule()
    : super(
        code: const LintCode(
          name: 'mateclaw_avoid_material_in_view_model',
          problemMessage:
              'ViewModel must not import UI libraries. Use flutter/foundation.dart if ChangeNotifier is needed.',
        ),
      );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    if (!_isViewModelFile(resolver.path)) {
      return;
    }

    context.registry.addImportDirective((node) {
      final uri = node.uri.stringValue;
      if (uri == 'package:flutter/material.dart' || uri == 'dart:ui') {
        reporter.atNode(node.uri, code);
      }
    });
  }
}

class AvoidBuildContextInViewModelRule extends DartLintRule {
  const AvoidBuildContextInViewModelRule()
    : super(
        code: const LintCode(
          name: 'mateclaw_avoid_build_context_in_view_model',
          problemMessage:
              'ViewModel must not depend on BuildContext. Expose state and let the View map it to UI behavior.',
        ),
      );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    if (!_isViewModelFile(resolver.path)) {
      return;
    }

    context.registry.addSimpleIdentifier((node) {
      if (node.name == 'BuildContext') {
        reporter.atNode(node, code);
      }
    });
  }
}

class AvoidDataLayerImportInViewRule extends DartLintRule {
  const AvoidDataLayerImportInViewRule()
    : super(
        code: const LintCode(
          name: 'mateclaw_avoid_data_layer_import_in_view',
          problemMessage:
              'View layer must not import Service or Repository classes directly. Use a ViewModel boundary.',
        ),
      );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    if (!_isViewFile(resolver.path)) {
      return;
    }

    context.registry.addImportDirective((node) {
      final uri = node.uri.stringValue;
      if (uri == null) {
        return;
      }

      final normalized = uri.replaceAll('\\', '/').toLowerCase();
      final importsDataLayer =
          normalized.contains('/data/') ||
          normalized.contains('/services/') ||
          normalized.contains('/repositories/');
      final importsServiceOrRepository =
          normalized.contains('service') ||
          normalized.contains('repository') ||
          normalized.contains('api') ||
          normalized.contains('database');

      if (importsDataLayer && importsServiceOrRepository) {
        reporter.atNode(node.uri, code);
      }
    });
  }
}

class AvoidHardcodedVisibleTextRule extends DartLintRule {
  const AvoidHardcodedVisibleTextRule()
    : super(
        code: const LintCode(
          name: 'mateclaw_avoid_hardcoded_visible_text',
          problemMessage:
              'User-visible text must come from AppLocalizations or context.l10n.',
        ),
      );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    if (!_isProjectLibFile(resolver.path) ||
        _isGeneratedOrL10nFile(resolver.path)) {
      return;
    }

    context.registry.addInstanceCreationExpression((node) {
      if (node.constructorName.type.toSource() != 'Text') {
        return;
      }

      final arguments = node.argumentList.arguments;
      if (arguments.isEmpty) {
        return;
      }

      final firstArgument = arguments.first;
      if (firstArgument is SimpleStringLiteral &&
          _looksUserVisible(firstArgument.value)) {
        reporter.atNode(firstArgument, code);
      }
    });

    context.registry.addNamedExpression((node) {
      final name = node.name.label.name;
      if (name != 'tooltip' &&
          name != 'semanticsLabel' &&
          name != 'label' &&
          name != 'hintText' &&
          name != 'helperText' &&
          name != 'errorText') {
        return;
      }

      final expression = node.expression;
      if (expression is SimpleStringLiteral &&
          _looksUserVisible(expression.value)) {
        reporter.atNode(expression, code);
      }
    });
  }
}

bool _isProjectLibFile(String path) {
  final normalized = path.replaceAll('\\', '/');
  return normalized.contains('/lib/') && normalized.endsWith('.dart');
}

bool _isViewModelFile(String path) {
  final normalized = path.replaceAll('\\', '/').toLowerCase();
  return _isProjectLibFile(path) &&
      (normalized.contains('/viewmodel/') ||
          normalized.endsWith('_view_model.dart') ||
          normalized.endsWith('_viewmodel.dart'));
}

bool _isViewFile(String path) {
  final normalized = path.replaceAll('\\', '/').toLowerCase();
  return _isProjectLibFile(path) &&
      (normalized.contains('/view/') ||
          normalized.endsWith('_page.dart') ||
          normalized.endsWith('_screen.dart'));
}

bool _isGeneratedOrL10nFile(String path) {
  final normalized = path.replaceAll('\\', '/').toLowerCase();
  return normalized.contains('/lib/l10n/') ||
      normalized.endsWith('.g.dart') ||
      normalized.endsWith('.freezed.dart') ||
      normalized.endsWith('.gen.dart');
}

bool _looksUserVisible(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    return false;
  }

  if (trimmed.startsWith('assets/') ||
      trimmed.startsWith('/') ||
      trimmed.startsWith('http://') ||
      trimmed.startsWith('https://')) {
    return false;
  }

  return RegExp(r'[A-Za-z\u4e00-\u9fff]').hasMatch(trimmed);
}
