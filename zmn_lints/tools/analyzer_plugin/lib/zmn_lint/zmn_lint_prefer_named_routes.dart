import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:candies_analyzer_plugin/candies_analyzer_plugin.dart';

/// @author：TianYu
/// @describe：对于 原生跳转 的代码规范
/// Copyright © 2023 Chongqing woodpecker network technology co., Ltd. All rights reserved.

/// The 'prefer_named_routes' lint
class ZmnLintPreferNamedRoutes extends DartLint {
  @override
  String get code => 'prefer_named_routes';

  @override
  String get message => '【强制】跳转页面必须使用 Get.toNamed(Routes.xxxPage); 而非其他';

  @override
  String? get correction => 'Click \'prefer_named_routes\' to show how to generate named routes const automatically.';

  @override
  String? get url => 'https://pub.dev/packages/ff_annotation_route';

  @override
  AnalysisErrorSeverity get severity => AnalysisErrorSeverity.ERROR;

  @override
  SyntacticEntity? matchLint(AstNode node) {
    if (node is MethodInvocation) {
      final String methodName = node.methodName.toString();
      final String nodeString = node.toString();
      if ((nodeString.startsWith('Navigator.') || nodeString.contains('MaterialPageRoute') || nodeString.contains('CupertinoPageRoute')) && (methodName.toLowerCase().contains('push') && !methodName.contains('Named'))) {
        return node;
      }
    }
    return null;
  }
}
