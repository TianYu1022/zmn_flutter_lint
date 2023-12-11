import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' hide Element;
import 'package:candies_analyzer_plugin/candies_analyzer_plugin.dart';
// ignore: implementation_imports
import 'package:analyzer/src/pubspec/pubspec_validator.dart';

/// 避免使用某个package
class RemoveDependency extends YamlLint {
  RemoveDependency({required this.package});
  final String package;
  @override
  String get code => 'remove_${package}_dependency';

  @override
  String get message => 'Remove $package dependency';

  @override
  String? get correction => 'Remove $package dependency';

  @override
  AnalysisErrorSeverity get severity => AnalysisErrorSeverity.WARNING;

  @override
  String? get url => null;

  @override
  Iterable<SourceRange> matchLint(
    YamlNode root,
    String content,
    LineInfo lineInfo,
  ) sync* {
    if (root is YamlMap && root.containsKey(PubspecField.DEPENDENCIES_FIELD)) {
      final YamlNode dependencies = root.nodes[PubspecField.DEPENDENCIES_FIELD]!;
      if (dependencies is YamlMap && dependencies.containsKey(package)) {
        final YamlNode get = dependencies.nodes[package]!;
        int start = dependencies.span.start.offset;
        final int end = get.span.start.offset;
        final int index = content.substring(start, end).indexOf('$package: ');
        start += index;
        yield SourceRange(start, get.span.end.offset - start);
      }
    }
  }
}

/// 避免使用本地某个package，例如：提醒不要使用本地的flutter_libs
class RemoveLocalDependency extends YamlLint {
  RemoveLocalDependency({required this.package});
  final String package;
  @override
  String get code => 'avoid_use_${package}_local_dependency';

  @override
  String get message => 'Avoid use $package local dependency';

  @override
  String? get correction => 'Avoid use $package local dependency';

  @override
  AnalysisErrorSeverity get severity => AnalysisErrorSeverity.WARNING;

  @override
  String? get url => null;

  @override
  Iterable<SourceRange> matchLint(
    YamlNode root,
    String content,
    LineInfo lineInfo,
  ) sync* {
    if (root is YamlMap && root.containsKey(PubspecField.DEPENDENCIES_FIELD)) {
      final YamlNode dependencies = root.nodes[PubspecField.DEPENDENCIES_FIELD]!;
      if (dependencies is YamlMap && dependencies.containsKey(package)) {
        final YamlNode get = dependencies.nodes[package]!;
        // 引用的是path本地路径的，提醒修改
        if (get.span.text.startsWith('path:')) {
          int start = dependencies.span.start.offset;
          final int end = get.span.start.offset;
          final int index = content.substring(start, end).indexOf('$package: ');
          start += index;
          yield SourceRange(start, get.span.end.offset - start);
        }
      }
    }
  }
}
