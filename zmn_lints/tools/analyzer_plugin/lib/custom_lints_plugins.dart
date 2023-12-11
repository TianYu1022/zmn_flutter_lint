import 'package:candies_analyzer_plugin/candies_analyzer_plugin.dart';

import 'package:zmn_lints_analyzer_plugin/prefer_ymal_remove_lib.dart';
import 'package:zmn_lints_analyzer_plugin/prefer_json_lints.dart';
import 'zmn_lint/zmn_lint_call_super_dispose.dart';
import 'zmn_lint/zmn_lint_prefer_asset_const.dart';
import 'zmn_lint/zmn_lint_prefer_named_routes.dart';
import 'zmn_lint/zmn_lint_prefer_safe_set_state.dart';

import 'zmn_lint/zmn_lint_good_doc_comments.dart';

class CustomLintPlugin extends CandiesAnalyzerPlugin {
  @override
  String get name => 'zmn_lints';

  /// 检测文件的类型，需要检测带哪些后缀的文件
  @override
  List<String> get fileGlobsToAnalyze => const <String>[
        '**/*.dart',
        '**/*.yaml',
        '**/*.json',
      ];

  /// 这里添加自定义Lints
  @override
  List<DartLint> get dartLints => <DartLint>[
        ZmnLintPreferAssetConst(),
        ZmnLintPreferNamedRoutes(),
        ZmnLintPreferSafeSetState(),

        ZmnLintMustCallSuperDispose(),
        ZmnLintEndCallSuperDispose(),

        ZmnLintGoodDocComments(),

        // PerferVmClassPrefix(),
      ];

  /// yaml里的lint规则，例如：避免使用某个package
  @override
  List<YamlLint> get yamlLints => <YamlLint>[
        RemoveDependency(package: 'webview_flutter'),
        RemoveLocalDependency(package: 'flutter_libs'),
      ];

  /// 其他文件类型lint规则，例如：检测json数据value不能有相同的值
  @override
  List<GenericLint> get genericLints => <GenericLint>[
        RemoveDuplicateValue(),
      ];
}
