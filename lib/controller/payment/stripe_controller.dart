import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_plo/views/widgets/dialog/alert_dialog.dart';
import '../../routes/navigation_service.dart';

import '../../services/api_end_point.dart';
import '../../services/service.dart';

class StripeController with ChangeNotifier {
  bool isStripeConnected = false;
  Map stripeSummary = {};

  Map holdPostItemDataToPostItAfterStripeVerification = {};

  List holdPostImagesAndVideoDataToPostItAfterStripeVarification = [];

  Future<void> checkIsUserConnectedWithStrip(context) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet Connection", context);
      return;
    } else {
      try {
        var res = await APICall.postRequest(
          endPoint: APIEndPoint.checkStripeAccountStatus,
          requestData: {},
        );
        if (res["status"] == 200) {
          isStripeConnected = res['is_connected'];
          stripeSummary = res['stripeSummary'];
          notifyListeners();
        } else if (res["status"] == 400) {
          AlertDialogBox.showSnackBar("${res["message"]}", context);
        }
      } catch (error) {
        print("Error getting profile $error");
      }
    }
  }

  String tokenKeyForAutoLogin = "myPloToken";
  String stripUlr = "";

  Future<void> callAPi(context) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet Connection", context);
      return;
    } else {
      try {
        var res = await APICall.postRequest(
          endPoint: APIEndPoint.stripeVarificationLink,
          requestData: {"type": "app"},
        );
        if (res["status"] == 200) {
          stripUlr = res['url'];
          // NavigationService.instance.pushNamed(Routes.webview);
          Navigator.pushNamed(context, "/webview");
        } else if (res["status"] == 400) {
          AlertDialogBox.showSnackBar("${res["message"]}", context);
        }
      } catch (error) {
        print("Error getting profile $error");
      }
    }
  }

  Future<bool> checkInternetAvailableOrNot() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    }
  }
}
