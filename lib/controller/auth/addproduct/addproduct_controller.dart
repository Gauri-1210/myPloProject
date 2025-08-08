import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:my_plo/model/addProduct_model/activecategories_model.dart';
import 'package:my_plo/model/addProduct_model/shippingsize_model.dart';
import 'package:my_plo/model/profile_model/userdashboardData.dart';
import 'package:my_plo/model/profile_model/userdata.dart';

import 'package:my_plo/services/api_end_point.dart';
import 'package:my_plo/services/service.dart';
import 'package:my_plo/views/widgets/dialog/alert_dialog.dart';

class AddproductController with ChangeNotifier {
  List<Categories> productCategories = [];
  Future<void> getCategories({required context, required requestData}) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet connection", context);
      return;
    } else {
      try {
        final result = await APICall.postRequest(
          endPoint: APIEndPoint.activecategories,
          requestData: requestData,
        );
        if (result["status"] == 200) {
          final activeCategoriesModel = activeCategoriesModelFromJson(
            jsonEncode(result),
          );
          productCategories = activeCategoriesModel.data ?? [];

          print(productCategories.length);

          print("Categories  $activeCategoriesModel ");
        } else if (result["status"] == 400) {
          AlertDialogBox.showSnackBar(result["message"], context);
        }
      } catch (error) {
        AlertDialogBox.showSnackBar("$error", context);
      }
    }
  }

  List<ShippingSize> shippingSize = [];
  Future<void> getshippingSize({required context, required requestData}) async {
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet connection", context);
      return;
    } else {
      try {
        final result = await APICall.postRequest(
          endPoint: APIEndPoint.shippingSize,
          requestData: requestData,
        );
        if (result["status"] == 200) {
          final shippingSizeModel = shippingSizeModelFromJson(
            jsonEncode(result),
          );
          shippingSize = shippingSizeModel.data ?? [];
          notifyListeners();

          print(shippingSize.length);

          print("Categories  $shippingSizeModel ");
        } else if (result["status"] == 400) {
          AlertDialogBox.showSnackBar(result["message"], context);
        }
      } catch (error) {
        AlertDialogBox.showSnackBar("$error", context);
      }
    }
  }

  Future<void> addProduct(context, requestData, images) async {
    print(requestData);
    print(images);
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet Connection", context);

      return;
    } else {
      try {
        var res = await APICall.multiPartrequest(
          endPoint: APIEndPoint.addOrUpdateProduct,
          requestData: requestData,
          requestImages: images,
        );
        if (res["status"] == 200) {
          // NavigationService.instance
          //     .pushAndRemove(Routes.bottombar, arguments: 4);
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/bottomnavigation",
            (route) => false,
            arguments: 4,
          );

          AlertDialogBox.showSnackBar("${res["message"]}", context);
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
