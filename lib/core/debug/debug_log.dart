import 'package:flutter/foundation.dart';

void debugLog(String message, {Map<String, Object?>? data}) {
  if (!kDebugMode) {
    return;
  }

  final buffer = StringBuffer('[Mateclaw] $message');
  if (data != null && data.isNotEmpty) {
    buffer.write(' | ');
    buffer.write(
      data.entries
          .map((entry) => '${entry.key}=${_formatValue(entry.value)}')
          .join(', '),
    );
  }
  debugPrint(buffer.toString());
}

String _formatValue(Object? value) {
  return switch (value) {
    null => 'null',
    final String value => '"$value"',
    final Iterable<Object?> value => '[${value.map(_formatValue).join(', ')}]',
    _ => value.toString(),
  };
}
