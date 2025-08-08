import 'package:flutter/material.dart';
import 'package:my_plo/controller/payment/stripe_controller.dart';

import 'package:provider/provider.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;
  @override
  void initState() {
    StripeController stripeController = Provider.of(context, listen: false);
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print("Loading progress: $progress%");
            Center(child: CircularProgressIndicator(color: Colors.white));
          },
          onPageStarted: (String url) {
            print("Start...........");
          },
          onPageFinished: (String url) {
            print("Page fineshed..........");
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(stripeController.stripUlr));
  }

  @override
  Widget build(BuildContext context) {
    StripeController stripeController = Provider.of(context, listen: false);
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Verify Identity'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Default back button icon
            onPressed: () {
              Navigator.pop(context);
              stripeController.checkIsUserConnectedWithStrip(context);
            },
          ),
        ),
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
