// import 'dart:convert';
import 'dart:isolate';
// import 'package:analyzer/dart/analysis/results.dart';
// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:analyzer/dart/ast/syntactic_entity.dart';
// import 'package:analyzer/dart/ast/token.dart';
// import 'package:analyzer/dart/ast/visitor.dart';

// import 'package:analyzer/source/source_range.dart';
// import 'package:analyzer_plugin/protocol/protocol_common.dart' hide Element;
// import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:candies_analyzer_plugin/candies_analyzer_plugin.dart';
// import 'package:analyzer/src/pubspec/pubspec_validator.dart';

import 'package:zmn_lints_analyzer_plugin/custom_lints_plugins.dart';

CandiesAnalyzerPlugin get plugin => CustomLintPlugin();

// This file must be 'plugin.dart'
void main(List<String> args, SendPort sendPort) {
  // for performance, default is false, if you want to check log, set it to true.
  CandiesAnalyzerPluginLogger().shouldLog = false;
  CandiesAnalyzerPluginLogger().logFileName = 'zmn_lints';
  CandiesAnalyzerPluginStarter.start(
    args,
    sendPort,
    plugin: plugin,
  );
}
