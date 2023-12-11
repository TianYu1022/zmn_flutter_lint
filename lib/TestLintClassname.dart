import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmn_flutter_lint/r.dart';
import 'package:zmn_flutter_lint/test_page.dart';

/// @author：TianYu
/// @describe：
/// createTime：2023/12/8 18:50
/// Copyright © 2023 Chongqing woodpecker network technology co., Ltd. All rights reserved.

/**
 * 错误注释格式
 */
class Test_LintClassName extends StatefulWidget {
  //
  const Test_LintClassName({Key? key}) : super(key: key);

  @override
  State<Test_LintClassName> createState() => _TestLintClassNameState();
}

const testRouteName = '';

class Routes {
  static const testPage = '/testPage';
}

class _TestLintClassNameState extends State<Test_LintClassName> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {});
    }
    setState(() {});

    Image.asset('assets/images/ic_test_image.png');
    Image.asset(R.ic_test_image);

    Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage()));
    Get.toNamed(Routes.testPage);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  dispose() {
    // super.dispose();
    // String error = '';
  }
}
