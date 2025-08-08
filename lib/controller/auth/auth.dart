import 'package:flutter/material.dart';
import 'package:my_plo/services/api_end_point.dart';

import 'package:my_plo/views/widgets/dialog/alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../services/service.dart';

class AuthController with ChangeNotifier {
  String tokenKeyForAutoLogin = "myplotoken";

  Future<void> login({required context, required requestData}) async {
    print(requestData);
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet Connection", context);
      return;
    } else {
      try {
        final result = await APICall.postRequest(
          endPoint: APIEndPoint.login,
          requestData: requestData,
        );
        if (result["status"] == 200) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(tokenKeyForAutoLogin, result["token"]);
          print("tokennnn ${result["token"]}");
          notifyListeners();
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/bottomnavigation",
            (route) => false,
          );
        } else if (result["status"] == 400) {
          AlertDialogBox.showSnackBar("User Is not Sign Up", context);
        }

        print("API Response $result");
      } catch (error) {
        AlertDialogBox.showSnackBar("$error", context);
      }
    }
  }

  // userSignup(Map signupdata, context) async {
  //   String signtoken = "myplo_token";
  //   Map signupResponse = {
  //     "message": "User is signed in succesfully!",
  //     "user": {
  //       "fullName": "Live user",
  //       "email": "1@mailinator.com",
  //       "password": "hjgj",
  //       "status": false,
  //       "stripeAccountId": "",
  //       "role": "Vendor",
  //       "averageRating": 0,
  //       "type": "manual",
  //       "userName": "Devil@d",
  //       "_id": "6875eea7f435e36ae08cf67b",
  //       "createdAt": "2025-07-15T06:01:11.663Z",
  //       "updatedAt": "2025-07-15T06:01:11.663Z",
  //       "__v": 0,
  //     },
  //     "token":
  //         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2ODc1ZWVhN2Y0MzVlMzZhZTA4Y2Y2N2IiLCJlbWFpbCI6IjFAbWFpbGluYXRvci5jb20iLCJyb2xlIjoiVmVuZG9yIiwiaWF0IjoxNzUyNTU5MjcyfQ.e50uxO-C4yFc9D9YWTrDcE42rEuYyV1xAsIMHiyGD4Q",
  //     "status": 200,
  //   };

  //   print(signupdata);
  //   //     void checkLoginStatus(BuildContext context) async {
  //   //   String? savedName = await Shared_Preferences.getUsername();
  //   //   final name = nameController.text;

  //   //   if (savedName == null) {
  //   //     await Shared_Preferences.saveUsername(name);
  //   //     Navigator.pushReplacementNamed(context, '/third');
  //   //   } else {
  //   //     Navigator.pushReplacementNamed(context, '/first');
  //   //   }
  //   // }

  //   // print(signupResponse["status"]);
  //   if (signupResponse["status"] == 200) {
  //     String signuptoken = signupResponse["token"];

  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setString(signtoken, signuptoken);

  //     Navigator.pushNamedAndRemoveUntil(
  //       context,
  //       '/bottomnavigation',
  //       (route) => false,
  //     );
  //   } else if (signupResponse["status"] == 400) {
  //     // print(signupResponse["message"]);
  //     // AlertDialogBox.alertDialog(
  //     //   context,
  //     //   errorMessage: signupResponse["message"],
  //     // );
  //     AlertDialogBox.showSnackBar(signupResponse["message"], context);
  //   } else {}
  // }

  forgotpassword(Map forgotemaildata) {
    print(forgotemaildata);
  }

  // isUserAlreadyLoggedIn(BuildContext context) async {
  //   String signtoken = "myplo_token";
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String? userToken = prefs.getString(signtoken);

  //   if (userToken == null || userToken.isEmpty) {
  //     Navigator.pushNamedAndRemoveUntil(
  //       context,
  //       '/loginscreen',
  //       (route) => false,
  //     );
  //   } else {
  //     Navigator.pushNamedAndRemoveUntil(
  //       context,
  //       '/bottomnavigation',
  //       (route) => false,
  //     );
  //   }
  // }

  // Map userSignUpData = {};

  Future<void> userSignup(signupdata, context) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet Connection", context);
      return;
    } else {
      try {
        final res = await APICall.postRequest(
          endPoint: APIEndPoint.signup,
          requestData: signupdata,
        );
        if (res["status"] == 200) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final userToken = res['token'];
          prefs.setString(tokenKeyForAutoLogin, userToken);

          Navigator.pushNamedAndRemoveUntil(
            context,
            "/bottomnavigation",
            (route) => false,
          );
        } else if (res["status"] == 400) {
          print("........");
          AlertDialogBox.showSnackBar(" ${res["message"]}", context);
        }
      } catch (error) {
        print("Error 12345 $error");
      }
    }
  }

  Future<void> changeProfilePassword(changepassword, context) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet Connection", context);
      return;
    } else {
      try {
        final res = await APICall.postRequest(
          endPoint: APIEndPoint.changeprofilepassword,
          requestData: changepassword,
        );
        if (res["status"] == 200) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final userToken = res['token'];
          prefs.setString(tokenKeyForAutoLogin, userToken);
          AlertDialogBox.showSnackBar(
            " Password is updated successfully",
            context,
          );
        } else if (res["status"] == 400) {
          print("........");
          AlertDialogBox.showSnackBar(" ${res["message"]}", context);
        }
      } catch (error) {
        print("Error 12345 $error");
      }
    }
  }

  Future<void> userlogout(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(tokenKeyForAutoLogin);
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/loginscreen",
      (route) => false,
    );
  }

  Future<bool> isUserAlreadyLoggedIn(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString(tokenKeyForAutoLogin);
    print("token value $userToken");
    if (userToken != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkInternetAvailableOrNot() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      // final result = await InternetAddress.lookup('google.com');
      // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //   AlertDialogBox.showSnackBar("google Connection", context);

      //   return true;
      // }

      return false;
    }
  }
}
