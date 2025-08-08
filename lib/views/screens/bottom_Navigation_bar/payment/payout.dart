import 'package:flutter/material.dart';
import 'package:my_plo/controller/payment/stripe_controller.dart';
import 'package:my_plo/views/widgets/button.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PayoutScreen extends StatefulWidget {
  const PayoutScreen({super.key});

  @override
  State<PayoutScreen> createState() => _PayoutScreenState();
}

class _PayoutScreenState extends State<PayoutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeController stripeController = Provider.of(context, listen: false);
    stripeController.checkIsUserConnectedWithStrip(context);
  }

  actionMethod() {
    lunchStripeDashboard("https://dashboard.stripe.com/login");
  }

  ontapp() {}

  bool isStripeConnected = true;

  commonCarAfterStripeConnection({required String title, required value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          "\$ ${value}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  lunchStripeDashboard(url) async {
    print(url);
    final Uri _url = Uri.parse(url);
    try {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 50,
        centerTitle: true,
        title: Text(
          "Get Paid with Stripe",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Color(0xFFD9D9D9), // Line color
            height: 1.5, // Line thickness
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Consumer<StripeController>(
          builder: (context, stripeControler, _) => ListView(
            children: [
              stripeControler.isStripeConnected
                  ? Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Your Myplo Earning",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 25),
                        commonCarAfterStripeConnection(
                          title: "Total Earned",
                          value:
                              stripeControler.stripeSummary['totalEarned'] ??
                              "",
                        ),
                        SizedBox(height: 10),
                        commonCarAfterStripeConnection(
                          title: "Payouts Sent",
                          value:
                              stripeControler.stripeSummary['payoutsSent'] ??
                              "",
                        ),
                        SizedBox(height: 10),
                        commonCarAfterStripeConnection(
                          title: "Pending Earning",
                          value:
                              stripeControler
                                  .stripeSummary['pendingEarnings'] ??
                              "",
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDEDDDD),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(width: 10),
                            Text(
                              "Stripe Status  : Connected ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Payouts are automatic! Once your sale or booking is complete, Stripe sends your earnings straight to your account",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20),
                        Button.buildButton(
                          'Open Stripe Dashboard',
                          actionMethod,
                        ),

                        // actionMethod: () {
                        //   lunchStripeDashboard(
                        //       "https://dashboard.stripe.com/login");
                        // },
                        // title: 'Open Stripe Dashboard',
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/Group (18).png",
                          width: MediaQuery.of(context).size.width / 4,
                        ),
                        SizedBox(height: 10),

                        // Text(
                        //   "Stripe Verification",
                        //   style: TextStyle(
                        //     fontSize: FontSize.font16,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        Text(
                          " When someone buys your party supplies or books your vendor services, your payout is processed through Stripe. It’s fast, secure, and only takes a minute to connect your account",
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Click below to link your Stripe account and start earning on MyPlo.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 25),
                        stripeControler.isStripeConnected
                            ? Button.buildButton('Stripe Connected', ontapp)
                            // AppCommonButton(
                            //     actionMethod: () {},
                            //     title: 'Stripe Connected',
                            //   )
                            : GestureDetector(
                                onTap: () {
                                  stripeControler.callAPi(context);
                                },
                                child: Container(
                                  height: 45,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    // border: Border.all(color: Color(0xFF5DA3FF)) ,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(25),
                                    gradient: LinearGradient(
                                      colors: [Colors.blue, Colors.purple],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Connect Stripe',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                        // Button.buildButton('Connect Stripe',stripeControler.callAPi(context))
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
