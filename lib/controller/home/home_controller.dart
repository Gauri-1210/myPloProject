import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_plo/model/home_model/user_address_model.dart';
import 'package:my_plo/services/api_end_point.dart';
import 'package:my_plo/services/service.dart';
import 'package:my_plo/views/widgets/dialog/alert_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../model/home_model/categoryproductdatamodel.dart';
import '../../model/home_model/userhomemodel.dart';

class HomeController with ChangeNotifier {
  List<Category> homeScreenCategory = [];
  bool isEmailVerified = false;
  Future<void> getUserHomeData({required context, required requestData}) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet connection", context);
      return;
    } else {
      try {
        final result = await APICall.postRequest(
          endPoint: APIEndPoint.appHomeData,
          requestData: requestData,
        );
        if (result["status"] == 200) {
          final userHomeDataModel = userHomeDataModelFromJson(
            jsonEncode(result),
          );
          homeScreenCategory = userHomeDataModel.categories ?? [];

          isEmailVerified = result['is_mail_connected'];
          notifyListeners();
          print(homeScreenCategory.length);

          print("userHomeDataModel  $userHomeDataModel ");
        } else if (result["status"] == 400) {
          AlertDialogBox.showSnackBar(result["message"], context);
        }
      } catch (error) {
        AlertDialogBox.showSnackBar("$error", context);
      }
    }
  }

  List<CategoryProductData> categoryProductData = [];
  CategoryProductData? categorySingleProductData;
  Future<void> getCategoryProductData({
    required context,
    required requestData,
  }) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet connection", context);
      return;
    } else {
      try {
        final result = await APICall.postRequest(
          endPoint: APIEndPoint.appHomeData,
          requestData: requestData,
        );
        if (result["status"] == 200) {
          final categoryProductDataModel = categoryProductDataModelFromJson(
            jsonEncode(result),
          );
          categoryProductData = categoryProductDataModel.data ?? [];
          print("CategoryProductData ${categoryProductDataModel}");
          Navigator.pushNamed(context, "/partyfurther");
        } else if (result["status"] == 400) {
          AlertDialogBox.showSnackBar(result["message"], context);
        }
      } catch (error) {
        AlertDialogBox.showSnackBar("$error", context);
      }
    }
  }

  List subCategoryData = [];
  Future<void> getsubcategorybycategoryId({
    required context,
    required requestData,
  }) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet connection", context);
      return;
    } else {
      try {
        final result = await APICall.postRequest(
          endPoint: APIEndPoint.subCategorybyId,
          requestData: requestData,
        );
        if (result["status"] == 200) {
          subCategoryData = result["data"];
          Navigator.pushNamed(context, "/vendorsub");
        } else if (result["status"] == 400) {
          AlertDialogBox.showSnackBar(result["message"], context);
        }
      } catch (error) {
        AlertDialogBox.showSnackBar("$error", context);
      }
    }
  }

  List<UserAddressData> userAddress = [];
  String productIamge = "";
  String productTitle = "";
  num productPrice = 0;
  String productId = "";
  String sellerId = "";
  String address = ""; //in case of buying party supply product

  Future<void> getAvailableAddress(context) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet Connection", context);
      return;
    } else {
      try {
        var res = await APICall.postRequest(
          endPoint: APIEndPoint.getUserAddress,
          requestData: {},
        );
        if (res["status"] == 200) {
          final userAddressModel = userAddressModelFromJson(json.encode(res));
          userAddress = userAddressModel.data ?? [];
          notifyListeners();
        } else if (res["status"] == 400) {
          AlertDialogBox.showSnackBar("${res["message"]}", context);
        }
      } catch (error) {
        print("Error getting profile $error");
      }
    }
  }

  num calculateShippingRate = 0;
  Future<void> getShippingCharges(context, requestData) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet Connection", context);
      return;
    } else {
      try {
        var res = await APICall.postRequest(
          endPoint: APIEndPoint.calculateShippingRate,
          requestData: requestData,
        );
        if (res["status"] == 200) {
          calculateShippingRate = res['data']['shippingCost'] ?? 0;
          notifyListeners();
        } else if (res["status"] == 400) {
          AlertDialogBox.showSnackBar("${res["message"]}", context);
        }
      } catch (error) {
        print("Error getting profile $error");
      }
    }
  }

  Future<void> addaddress(context, requestData) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet Connection", context);
      return;
    } else {
      try {
        var res = await APICall.postRequest(
          endPoint: APIEndPoint.addOrUpdateAddress,
          requestData: requestData,
        );
        if (res["status"] == 200) {
          Navigator.pop(context);
          getAvailableAddress(context);
        } else if (res["status"] == 400) {
          AlertDialogBox.showSnackBar("${res["message"]}", context);
        }
      } catch (error) {
        print("Error getting profile $error");
      }
    }
  }

  Future<void> deleteAvailableAddress(context, {required requestData}) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet Connection", context);
      return;
    } else {
      try {
        var res = await APICall.postRequest(
          endPoint: APIEndPoint.softDeleteAddress,
          requestData: requestData,
        );
        if (res["status"] == 200) {
          Navigator.pop(context);
          getAvailableAddress(context);
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
