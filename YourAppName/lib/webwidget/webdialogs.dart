import 'dart:ui';

import 'package:yourappname/players/cannotwatch.dart';
import 'package:yourappname/routes/routes_constant.dart';
import 'package:yourappname/webpages/webactivetv.dart';
import 'package:yourappname/webpages/webloginsocial.dart';
import 'package:yourappname/webpages/webotpverify.dart';
import 'package:flutter/material.dart';

class WebDialogs extends StatelessWidget {
  final String? dialogType, newPage, oldPage;
  final dynamic reqText;
  const WebDialogs({
    super.key,
    required this.dialogType,
    required this.newPage,
    required this.oldPage,
    required this.reqText,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: _openDialogByType(),
    );
  }

  Widget _openDialogByType() {
    switch (dialogType) {
      case RoutesConstant.loginSocialPage:
        return WebLoginSocial(
          newPage: newPage,
          oldPage: oldPage,
          reqText: reqText,
        );
      case RoutesConstant.loginOTPPage:
        return WebOTPVerify(
          reqText,
          newPage: newPage,
          oldPage: oldPage,
          reqText: reqText,
        );
      case RoutesConstant.activeTVPage:
        return WebActiveTV(
          newPage: newPage,
          oldPage: oldPage,
          reqText: reqText,
        );
      case RoutesConstant.cannotWatchPage:
        return const CannotWatch();
      default:
        return WebLoginSocial(
          newPage: newPage,
          oldPage: oldPage,
          reqText: reqText,
        );
    }
  }
}
