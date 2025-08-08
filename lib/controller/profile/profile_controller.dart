import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_plo/model/profile_model/userdashboardData.dart';
import 'package:my_plo/model/profile_model/userdata.dart';

import 'package:my_plo/services/api_end_point.dart';
import 'package:my_plo/services/service.dart';

import '../../views/widgets/dialog/alert_dialog.dart';

class ProfileController with ChangeNotifier {
  Data? userDataList;
  Future<void> getUserData({required context, required requestData}) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet connection", context);
      return;
    } else {
      try {
        final result = await APICall.postRequest(
          endPoint: APIEndPoint.userdashboarddata,
          requestData: requestData,
        );
        if (result["status"] == 200) {
          final userDashboardData = userDashboardDataFromJson(
            jsonEncode(result),
          );
          userDataList = userDashboardData.data;
          notifyListeners();

          // print(userDataList.length);

          print("userHomeDataModel  $userDashboardData ");
        } else if (result["status"] == 400) {
          AlertDialogBox.showSnackBar(result["message"], context);
        }
      } catch (error) {
        AlertDialogBox.showSnackBar("$error", context);
      }
    }
  }

  UserProfileData? userProfileDataList;
  Future<void> getUserProfileData({
    required context,
    required requestData,
  }) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet connection", context);
      return;
    } else {
      try {
        final result = await APICall.postRequest(
          endPoint: APIEndPoint.userData,
          requestData: requestData,
        );
        if (result["status"] == 200) {
          final userDataModel = userDataModelFromJson(jsonEncode(result));
          userDataList = userDataModel.data as Data?;
          notifyListeners();

          // print(userDataList.length);

          print("userHomeDataModel  $userDataModel ");
        } else if (result["status"] == 400) {
          AlertDialogBox.showSnackBar(result["message"], context);
        }
      } catch (error) {
        AlertDialogBox.showSnackBar("$error", context);
      }
    }
  }

  Future<void> verifyMailRequest(context, requestData) async {
    AlertDialogBox.showSnackBar(
      "Please check your email to verify your account.",
      context,
    );
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet Connection", context);
      return;
    } else {
      try {
        var res = await APICall.postRequest(
          endPoint: APIEndPoint.verifyEmailRequest,
          requestData: requestData,
          needToShowLoading: false,
        );
        if (res["status"] == 200) {
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
      return false;
    }
  }
}
