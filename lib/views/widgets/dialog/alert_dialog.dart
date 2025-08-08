import 'package:flutter/material.dart';
import 'package:my_plo/routes/navigation_service.dart';

class AlertDialogBox {
  static void alertDialog(
    BuildContext context, {
    errorMessage = "Something Went Wrong",
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // static void snackBar(
  //   BuildContext context, {
  //   snackbarError = "Something Went Wrong",
  // }) {
  //   ScaffoldMessenger.of(
  //     context,
  //   ).showSnackBar(SnackBar(content: Text(snackbarError)));
  // }
  static showSnackBar(String msg, context) {
    // BuildContext context =
    //     NavigationService.instance.navigationKey.currentContext!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: "OK",
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        content: Text("$msg"),
      ),
    );
  }

  static showLoader() {
    BuildContext context =
        NavigationService.instance.navigationKey.currentContext!;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  static hideLoader(BuildContext context) {
    Navigator.of(context).pop();
  }
}
