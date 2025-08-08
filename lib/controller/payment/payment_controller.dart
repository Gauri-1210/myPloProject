import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:my_plo/services/api_end_point.dart';
import 'package:my_plo/services/service.dart';
import 'package:my_plo/views/widgets/dialog/alert_dialog.dart';

class PaymentController with ChangeNotifier {
  //payment
  Map holdDataToSendWhenPaymentSuccess = {};
  Future<void> getStripPaymentToekn({
    required Map requestData,
    context,
    required amount,
  }) async {
    try {
      holdDataToSendWhenPaymentSuccess = requestData;
      var res = await APICall.postRequest(
        endPoint: APIEndPoint.createPaymentInstant,
        requestData: {"amount": amount},
      );
      if (res['status'] == 200) {
        print("Token for strip payment...  $res ${res}");
        makePaymentNow(res['data']['paymentIntent'], context);

        //android code
      } else {}
    } catch (error) {
      print("errors $error");
    }
  }

  Future<void> makePaymentNow(secretID, context) async {
    print("make Payment call");
    try {
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: secretID,
              merchantDisplayName: "MyPlo",
            ),
          )
          .then((value) => {});
      await displayPaymentSheet(context);

      final paymentIntent = await Stripe.instance.retrievePaymentIntent(
        secretID,
      );

      print("Payment ..... $paymentIntent");
      if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        holdDataToSendWhenPaymentSuccess['paymentMethod'] = 'stripe';
        holdDataToSendWhenPaymentSuccess['transaction_id'] = paymentIntent.id;
        holdDataToSendWhenPaymentSuccess['paymentResponse'] = json.encode(
          paymentIntent,
        );
        print(" prrrrrrr$holdDataToSendWhenPaymentSuccess");

        submitPayment(context, holdDataToSendWhenPaymentSuccess);

        try {} catch (error) {
          // onPaymentFailed(
          //   paymentMethod: "stripe",
          // );
          print("Error...1233444  $error");
        }
      } else {
        // onPaymentFailed(context, "stripe");
      }
    } catch (error) {
      print("error $error");
    }
  }

  Future<void> displayPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((_) {});
    } catch (error) {
      print("Error $error");
    }
  }

  Future<void> submitPayment(context, requestData) async {
    print("payment data $requestData");
    if (!await checkInternetAvailableOrNot()) {
      AlertDialogBox.showSnackBar("No Internet Connection", context);
      return;
    } else {
      try {
        if (requestData['productType'] == "user") {
          var res = await APICall.postRequest(
            endPoint: APIEndPoint.createOrder,
            requestData: requestData,
          );
          if (res["status"] == 200) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/bottomnavigation",
              (route) => false,
            );

            showDialog(
              context: context,
              barrierDismissible: false, // Prevents closing by tapping outside
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 80),
                      const SizedBox(height: 16),
                      const Text(
                        "Order Placed!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Your order was placed successfully.\nThank you for shopping with us! Check Profile Section for Order Update ",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close popup
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (res["status"] == 400) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/bottomnavigation",
              (route) => false,
            );

            showDialog(
              context: context,
              barrierDismissible: false, // Prevents closing by tapping outside
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 80),
                      const SizedBox(height: 16),
                      const Text(
                        "Order Placed!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Your order was placed successfully.\nThank you for shopping with us! \nCheck Profile Section for Order Update ",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close popup
                        },
                        child: const Text(
                          "OK",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        } else {
          // var res = await APICall.postRequest(
          //   endPoint: APIEndPoint.createBooking,
          //   requestData: requestData,
          // );
          // if (res["status"] == 200) {
          //   // NavigationService.instance.pushNamed(Routes.ordersuccess);
          // } else if (res["status"] == 400) {
          //   AlertDialogBox.showSnackBar("${res["message"]}", context);
          // }
        }
      } catch (error) {
        print("Error 12345 $error");
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
