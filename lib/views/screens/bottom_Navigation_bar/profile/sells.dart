import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_plo/controller/home/home_controller.dart';
import 'package:my_plo/controller/profile/profile_controller.dart';
import 'package:my_plo/services/api_end_point.dart';
import 'package:provider/provider.dart';

class SellsScreen extends StatefulWidget {
  const SellsScreen({super.key});
  @override
  _SellsState createState() => _SellsState();
}

class _SellsState extends State<SellsScreen> {
  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Provider.of<ProfileController>(
      context,
      listen: false,
    );
    HomeController homeController = Provider.of<HomeController>(
      context,
      listen: false,
    );
    return Scaffold(
      body: ListView(
        children: [
          ...List.generate(
            profileController.userDataList?.purchasedOrders?.length ?? 0,
            (index) {
              final item =
                  profileController.userDataList?.purchasedOrders?[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      isThreeLine: true,
                      leading: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        child: CachedNetworkImage(
                          width: 70,
                          height: 70,
                          imageUrl:
                              "${APIEndPoint.serverURL}${item!.productId!.gallery![0]}",
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      title: Text("${item!.productId!.title}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            " \$${item.productId!.price! + homeController.calculateShippingRate}",
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                          Text("${item.productId!.createdAt}"),

                          // Text(
                          //   "Read More",
                          //   style: TextStyle(
                          //     color: Colors.pink,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          //     ListTile(
          //       leading: Image.asset(
          //         'assets/images/babyshower3.jpg',
          //         width: 60,
          //         height: 60,
          //         fit: BoxFit.cover,
          //       ),
          //       title: Text("Birthday Cake"),
          //       subtitle: Row(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Flexible(
          //             child: Text(
          //               "I hope you have a wonderful  and that all your wishes come true.",
          //               maxLines: 2,
          //             ),
          //           ),
          //           // Text(
          //           //   "Read More",
          //           //   style: TextStyle(
          //           //     color: Colors.pink,
          //           //     fontWeight: FontWeight.bold,
          //           //   ),
          //           // ),
          //         ],
          //       ),
          //     ),
        ],
      ),
    );
  }
}
