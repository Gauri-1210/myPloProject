import 'package:flutter/material.dart';
import 'package:my_plo/controller/home/home_controller.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/payment/payout.dart';
import 'package:my_plo/views/widgets/back.dart';
import 'package:provider/provider.dart';

class VendorSubclass extends StatefulWidget {
  const VendorSubclass({super.key});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<VendorSubclass> {
  void onback() {
    Navigator.pop(context);
  }

  // final List<Map<String, dynamic>> Items = [
  //   {"Item": "Birthday"},
  //   {"Item": "Farewell"},
  //   {"Item": "Anniversary"},
  // ];

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Provider.of<HomeController>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(leading: Back.buildBack(onback)),
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/vendorfurther");
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: homeController.subCategoryData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final item = homeController.subCategoryData[index];
            return Column(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.pink],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/images/my plo 1.png',
                      color: Colors.white,
                      height: 70,
                      width: 50,
                    ),
                  ),
                ),
                Text(item["categoryName"]),
              ],
            );
          },
        ),
      ),
    );
  }
}
