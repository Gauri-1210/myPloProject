import 'package:flutter/material.dart';
import 'package:my_plo/core/constants/appconstants.dart';
import 'package:my_plo/views/screens/modalbottomsheet.dart';
import 'package:my_plo/views/widgets/back.dart';

class Shipping extends StatefulWidget {
  const Shipping({super.key});
  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  void _showModalBottomsheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.2,
          width: double.infinity,
          child: Modalbottomsheet(),
        );
      },
    );
  }

  void onback() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shipping & Payment"),
        leading: Back.buildBack(onback),
      ),

      body: ListView(
        children: [
          Divider(),

          Padding(
            padding: const EdgeInsets.all(AppConstants.apphorizontal),
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

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 216, 215, 215),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You Haven't Added Any Shipping Address"),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(),
                      ),
                      onPressed: () {
                        _showModalBottomsheet(context);
                      },
                      child: Text("Add Address"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/shipping_payment");
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue, Colors.pink]),
          ),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Proceed To Payment", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
