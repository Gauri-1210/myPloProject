import 'package:flutter/material.dart';
import 'package:my_plo/core/constants/appconstants.dart';
import 'package:my_plo/views/widgets/back.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<PaymentMethod> {
  void onback() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Back.buildBack(onback)),

      body: Column(
        children: [
          Divider(),
          Column(
            children: [
              Image.asset(
                'assets/images/location.png',
                height: 180,
                width: 150,
              ),
              Text("Your Order Has been Confirmed"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.apphorizontal),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment Method",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Stripe",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Id",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("123456789"),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("\$299.98"),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Address",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("XYZ Street"),
                        Text("Near ABC road"),
                        Text("Rajasthan"),
                        Text("Jaipur"),
                        Text("302019"),
                        Text("9461475336"),
                      ],
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
          Column(
            children: [
              Text("Order Items"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 216, 215, 215),
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          "assets/images/babyshower3.jpg",
                          width: 80,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 25,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Birthday Cake"),
                            Text(
                              "\$499",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
