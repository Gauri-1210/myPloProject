import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:my_plo/routes/navigation_service.dart';
import 'package:my_plo/services/api_end_point.dart';
import 'package:my_plo/views/widgets/dialog/alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class APICall {
  static String userTokeKey = "myplotoken";
  static bool isLoading = false;

  static Future<dynamic> postRequest({
    required String endPoint,
    required dynamic requestData,
    bool needToShowLoading = true,
  }) async {
    print("Entered Post request");

    BuildContext context =
        NavigationService.instance.navigationKey.currentContext!;
    print("Entered Post request");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString(userTokeKey);
    print("User token $userToken");

    var apiUrl = Uri.parse(APIEndPoint.serverURL + endPoint);

    print("$apiUrl $requestData");
    try {
      if (isLoading == false && needToShowLoading) {
        isLoading = true;
        AlertDialogBox.showLoader();
      }
      final apiResponse = await http.post(
        apiUrl,
        headers: {
          'Content-type': 'application/json',
          if (userToken != null) 'Authorization': "Bearer $userToken",
        },
        body: json.encode(requestData),
      );
      print("Signup Data: ${jsonEncode(requestData)}");

      log("res ${apiResponse.body}");
      if (apiResponse.statusCode == 200) {
        if (isLoading && needToShowLoading) {
          isLoading = false;
          Navigator.pop(context);
        }

        final finalResponse = json.decode(apiResponse.body);

        return finalResponse;
      } else {
        if (isLoading && needToShowLoading) {
          isLoading = false;
          Navigator.pop(context);
        }
        if (apiResponse.statusCode == 400) {
          final finalResponse = json.decode(apiResponse.body);
          return finalResponse;
        } else {
          return {"status": 400, "message": "Something went wrong"};
        }
      }
    } catch (error) {
      print("Error catch");
      if (isLoading && needToShowLoading) {
        isLoading = false;
        Navigator.pop(context);
      }
      rethrow;
    }
  }

  static Future<dynamic> multiPartrequest({
    required String endPoint,
    required Map<String, String> requestData,
    required requestImages,
    bool needToShowLoading = true,
  }) async {
    BuildContext context =
        NavigationService.instance.navigationKey.currentContext!;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString(userTokeKey);
    print(".... $requestImages");
    print(".... $requestData");

    var apiUrl = Uri.parse("${APIEndPoint.serverURL}$endPoint");
    print(apiUrl);

    try {
      if (isLoading == false && needToShowLoading) {
        isLoading = true;
        AlertDialogBox.showLoader();
      }
      var request = http.MultipartRequest('POST', apiUrl);

      request.fields.addAll(requestData);

      for (int i = 0; i < requestImages.length; i++) {
        String filePath = requestImages[i]['path'];
        print("FIle path $filePath");
        String key = requestImages[i]['key'];

        // Determine the MIME type explicitly based on the file extension
        String mimeType;
        if (filePath.endsWith('.jpg') || filePath.endsWith('.jpeg')) {
          mimeType = 'image/jpeg';
        } else if (filePath.endsWith('.png')) {
          mimeType = 'image/png';
        } else if (filePath.endsWith('.mp4')) {
          mimeType = 'video/mp4';
        } else {
          mimeType = 'application/octet-stream'; // Fallback for unknown types
        }

        // Add the file with the correct MIME type
        request.files.add(
          await http.MultipartFile.fromPath(
            key,
            filePath,
            contentType: MediaType.parse(
              mimeType,
            ), // Set the MIME type explicitly
          ),
        );
      }

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        if (userToken != null) 'Authorization': "Bearer $userToken",
      });

      print("Ahe...");
      http.StreamedResponse apiResponse = await request.send();
      if (apiResponse.statusCode == 200) {
        if (isLoading && needToShowLoading) {
          isLoading = false;
          Navigator.pop(context);
        }
        // Get the response as a string
        String responseBody = await apiResponse.stream.bytesToString();
        final finalResponse = json.decode(responseBody);
        print(".....$finalResponse");
        return finalResponse;
      } else {
        if (isLoading && needToShowLoading) {
          isLoading = false;
          Navigator.pop(context);
        }
        if (apiResponse.statusCode == 400) {
          String responseBody = await apiResponse.stream.bytesToString();
          final finalResponse = json.decode(responseBody);
          print(".....$finalResponse");
          return finalResponse;
        } else {
          String responseBody = await apiResponse.stream.bytesToString();
          final finalResponse = json.decode(responseBody);
          print(".....$finalResponse");
          return {"status": 400, "message": "Something went wrong"};
        }
      }
    } catch (error) {
      print("Error catch");
      if (isLoading && needToShowLoading) {
        isLoading = false;
        Navigator.pop(context);
      }
      rethrow;
    }
  }
}
