import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:candies_analyzer_plugin/candies_analyzer_plugin.dart';

/// @author：TianYu
/// @describe：对于 资源文件的 的代码规范 ERROR 级别
/// Copyright © 2023 Chongqing woodpecker network technology co., Ltd. All rights reserved.

class ZmnLintPreferAssetConst extends DartLint {
  @override
  String get code => 'prefer_asset_const';

  @override
  // String? get url => 'https://pub.dev/packages/assets_generator';
  String? get url => 'https://alidocs.dingtalk.com/i/nodes/YMyQA2dXW797nmmYh7d5ebMlJzlwrZgb?utm_scene=team_space';

  @override
  String get message => '【强制】asset 资源使用不要直接写字符串，而应该使用定义好的 const 并且定义在 r.dart 下 \n Prefer to use asset const instead of a string.';

  @override
  String? get correction => 'Click \'prefer_asset_const\' to show how to generate asset const automatically.';

  @override
  AnalysisErrorSeverity get severity => AnalysisErrorSeverity.ERROR;

  bool _isString(ArgumentList argumentList) {
    for (final Expression argument in argumentList.arguments) {
      final String argumentString = argument.toString();
      return argumentString.startsWith('\'') && argumentString.endsWith('\'');
    }
    return false;
  }

  @override
  SyntacticEntity? matchLint(AstNode node) {
    if (node is MethodInvocation) {
      final String astNodeString = node.toString();
      if (astNodeString.startsWith('rootBundle.load') && _isString(node.argumentList)) {
        return node;
      }
    } else if (node is InstanceCreationExpression) {
      final String astNodeString = node.toString();
      if ((astNodeString.startsWith('AssetImage(') || astNodeString.startsWith('Image.asset(')) && _isString(node.argumentList)) {
        return node;
      }
    }

    return null;
  }
}
