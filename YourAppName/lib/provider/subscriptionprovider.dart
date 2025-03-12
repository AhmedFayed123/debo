import 'package:yourappname/utils/utils.dart';
import 'package:yourappname/model/subscriptionmodel.dart';
import 'package:yourappname/utils/constant.dart';
import 'package:yourappname/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionModel subscriptionModel = SubscriptionModel();

  bool loading = false;

  Future<void> getPackages() async {
    printLog("getPackages userID :==> ${Constant.userID}");
    loading = true;
    subscriptionModel = await ApiService().subscriptionPackage();
    printLog("get_package status :==> ${subscriptionModel.status}");
    printLog("get_package message :==> ${subscriptionModel.message}");
    loading = false;
    notifyListeners();
  }

  clearProvider() {
    printLog("<================ clearSubscriptionProvider ================>");
    subscriptionModel = SubscriptionModel();
  }
}
