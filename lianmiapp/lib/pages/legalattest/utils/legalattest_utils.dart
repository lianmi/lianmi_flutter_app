import 'dart:convert';

import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/legalattest/legalattest_router.dart';
import 'package:lianmiapp/util/app.dart';

class LegalAttestUtils {
  static void showLegalAttest(int id, String productId, String productName,
      int productPrice, String businessUsername) {
    //注意：中文记得先编码
    NavigatorUtils.push(
        App.context!,
        LegalAttestRouter.hetongPage +
            '?productId=${productId}&productName=${Uri.encodeComponent(productName)}&productPrice=${productPrice}&businessUsername=${businessUsername}&id=${id}');
  }
}
