import 'dart:convert';

import 'package:analyzer/source/source_range.dart';
import 'package:candies_analyzer_plugin/candies_analyzer_plugin.dart';

class RemoveDuplicateValue extends GenericLint {
  @override
  String get code => 'remove_duplicate_value';

  @override
  String? get url => null;

  @override
  Iterable<SourceRange> matchLint(
    String content,
    String file,
    LineInfo lineInfo,
  ) sync* {
    if (isFileType(file: file, type: '.json')) {
      final Map<dynamic, dynamic> map = jsonDecode(content) as Map<dynamic, dynamic>;

      final Map<dynamic, dynamic> duplicate = <dynamic, dynamic>{};
      final Map<dynamic, dynamic> checkDuplicate = <dynamic, dynamic>{};
      for (final dynamic key in map.keys) {
        final dynamic value = map[key];
        if (checkDuplicate.containsKey(value)) {
          duplicate[key] = value;
          duplicate[checkDuplicate[value]] = value;
        }
        checkDuplicate[value] = key;
      }

      if (duplicate.isNotEmpty) {
        for (final dynamic key in duplicate.keys) {
          final int start = content.indexOf('"$key"');
          final dynamic value = duplicate[key];
          final int end = content.indexOf(
                '"$value"',
                start,
              ) +
              value.toString().length +
              1;

          final int lineNumber = lineInfo.getLocation(end).lineNumber;

          bool hasComma = false;
          int commaIndex = end;
          int commaLineNumber = lineInfo.getLocation(commaIndex).lineNumber;

          while (!hasComma && commaLineNumber == lineNumber) {
            commaIndex++;
            final String char = content[commaIndex];
            hasComma = char == ',';
            commaLineNumber = lineInfo.getLocation(commaIndex).lineNumber;
          }

          yield SourceRange(start, (hasComma ? commaIndex : end) + 1 - start);
        }
      }
    }
  }

  @override
  String get message => 'remove duplicate value';
}
