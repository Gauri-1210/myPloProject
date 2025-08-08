import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_plo/controller/profile/profile_controller.dart';
import 'package:my_plo/services/api_end_point.dart';
import 'package:provider/provider.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Provider.of<ProfileController>(
      context,
      listen: false,
    );

    return Scaffold(
      body: ListView(
        children: [
          ...List.generate(profileController.userDataList?.offer?.length ?? 0, (
            index,
          ) {
            final item = profileController.userDataList?.offer?[index];
            String path = "${APIEndPoint.serverURL}${item!.productId!.gallery}";
            print("item $item");
            print("path $path");
            return Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),

                      child:
                          // Image.network(
                          //   "${APIEndPoint.serverURL}${item!.productId!.gallery![0]}",
                          //   fit: BoxFit.cover,
                          // ),
                          CachedNetworkImage(
                            width: 70,
                            height: 70,
                            imageUrl:
                                "${APIEndPoint.serverURL}${item.productId!.gallery![0]}",
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${item.productId!.title}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    Text(
                      "${item.productId!.price}",
                      style: TextStyle(color: Colors.pink),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                          ),

                          onPressed: () {
                            // Action for Rate
                          },

                          child: Text(
                            "${item.status}",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          // Card(
          //   color: Colors.white,
          //   child: ListTile(
          //     leading: Image.asset(
          //       'assets/images/babyshower3.jpg',
          //       width: 60,
          //       height: 60,
          //       fit: BoxFit.cover,
          //     ),
          //     title: Text("Birthday Cake"),
          //     subtitle: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           "\$200",
          //           style: TextStyle(
          //             color: Colors.pink,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         Text("1 February 2025"),
          //       ],
          //     ),

          //     trailing: ElevatedButton(
          //       style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),

          //       onPressed: () {
          //         // Action for Rate
          //       },

          //       child: Text("Pending", style: TextStyle(color: Colors.black)),
          //     ),
          //   ),
          // ),
          // // Divider(),
          // SizedBox(height: 10),
          // Card(
          //   color: Colors.white,
          //   child: ListTile(
          //     leading: Image.asset(
          //       'assets/images/babyshower3.jpg',
          //       width: 60,
          //       height: 60,
          //       fit: BoxFit.cover,
          //     ),
          //     title: Text("Birthday Cake"),
          //     subtitle: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           "\$200",
          //           style: TextStyle(
          //             color: Colors.pink,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         Text("1 February 2025"),
          //       ],
          //     ),

          //     trailing: ElevatedButton(
          //       style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          //       onPressed: () {
          //         // Action for Rate
          //       },

          //       child: Text("Rejected", style: TextStyle(color: Colors.white)),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 10),
          // Card(
          //   color: Colors.white,
          //   child: ListTile(
          //     leading: Image.asset(
          //       'assets/images/babyshower3.jpg',
          //       width: 60,
          //       height: 60,
          //       fit: BoxFit.cover,
          //     ),
          //     title: Text("Birthday Cake"),
          //     subtitle: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           "\$200",
          //           style: TextStyle(
          //             color: Colors.pink,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         Text("1 February 2025"),
          //       ],
          //     ),

          //     trailing: ElevatedButton(
          //       style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          //       onPressed: () {},

          //       child: Text("Accepted", style: TextStyle(color: Colors.white)),
          //     ),
          //   ),
          // ),
          // Card(
          //   color: Colors.white,
          //   child: Column(
          //     children: [
          //       ListTile(
          //         leading: Image.asset(
          //           'assets/images/babyshower3.jpg',
          //           width: 60,
          //           height: 60,
          //           fit: BoxFit.cover,
          //         ),
          //         title: Text("Birthday Cake"),
          //         subtitle: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               "\$200",
          //               style: TextStyle(
          //                 color: Colors.pink,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             Text("1 February 2025"),
          //           ],
          //         ),
          //       ),
          //       Divider(),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //               backgroundColor: Colors.white,
          //               foregroundColor: Colors.green,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.zero,
          //               ),
          //             ),
          //             onPressed: () {},
          //             child: Text("Accept"),
          //           ),
          //           ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //               backgroundColor: Colors.white,
          //               foregroundColor: Colors.red,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.zero,
          //               ),
          //             ),
          //             onPressed: () {},
          //             child: Text("Reject"),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
