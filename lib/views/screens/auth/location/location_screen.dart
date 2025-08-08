import 'package:flutter/material.dart';
import 'package:my_plo/core/constants/appconstants.dart';
import 'package:my_plo/theme/imagetheme/images.dart';
import 'package:my_plo/theme/texttheme/textstyle_theme.dart';
import 'package:my_plo/views/widgets/back.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<LocationScreen> {
  final imageUrl =
      'https://www.sugar.org/wp-content/uploads/Birthday-Cake-1.png';
  void onback() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Back.buildBack(onback)),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 110),
                child: Image.asset('assets/images/my plo 1.png'),
              ),
              Text(
                "The Genuis Way to Buy & Sell Party LeftOvers",
                style: AppTheme.normal(),
                // TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 30),
          Column(children: [Image.asset(Images.finalLocation, height: 150)]),
          SizedBox(height: 60),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.apphorizontal,
            ),

            child: Column(
              children: [
                Text(
                  "Allow location access for seamless experience!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/bottomnavigation",
                          (route) => false,
                        );
                      },
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors: [Colors.purple, Colors.blue],
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/Vector (1).png",
                                height: 20,
                                width: 20,
                              ),
                              Text(
                                "Allow",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 60,
                    child: Text(
                      "Not Now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
