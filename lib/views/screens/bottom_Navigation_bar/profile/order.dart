import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_plo/controller/profile/profile_controller.dart';
import 'package:my_plo/services/api_end_point.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Provider.of<ProfileController>(
      context,
      listen: false,
    );
    return Scaffold(
      body: Consumer(
        builder: (context, value, child) {
          return ListView(
            children: [
              ...List.generate(
                profileController.userDataList?.sellingProducts?.length ?? 0,
                (index) {
                  final item =
                      profileController.userDataList?.sellingProducts?[index];
                  print("item $item");
                  return Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // ...item!.gallery!.map((imgpath) {
                          //   return ClipRRect(
                          //     borderRadius: BorderRadius.circular(12),

                          //     child: CachedNetworkImage(
                          //       width: 70,
                          //       height: 70,
                          //       imageUrl: "${APIEndPoint.serverURL}$imgpath",
                          //       fit: BoxFit.cover,
                          //       placeholder: (context, url) =>
                          //           Center(child: CircularProgressIndicator()),
                          //       errorWidget: (context, url, error) =>
                          //           Icon(Icons.error),
                          //     ),
                          //   );
                          // }
                          //),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),

                            child: CachedNetworkImage(
                              width: 70,
                              height: 70,
                              imageUrl:
                                  "${APIEndPoint.serverURL}${item!.gallery![0]}",
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item.title}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              Text(
                                "${item.price}",
                                style: TextStyle(color: Colors.pink),
                              ),
                            ],
                          ),

                          // Align(
                          //   alignment: Alignment.bottomRight,
                          //   child: TextButton.icon(
                          //     onPressed: () {},
                          //     icon: Icon(
                          //       Icons.arrow_forward_ios,
                          //       size: 14,
                          //       color: Colors.pink,
                          //     ),
                          //     label: Text(
                          //       "Rate",
                          //       style: TextStyle(color: Colors.pink),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );

          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // number of columns
              childAspectRatio: 3 / 2.2, // width/height ratio of each card
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: profileController.userDataList?.sellingProducts?.length,
            itemBuilder: (context, index) {
              final item =
                  profileController.userDataList?.sellingProducts![index];

              print("item $item  ${item?.title}");

              return Text(" ${item?.title}");

              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),

                        child: CachedNetworkImage(
                          // width: 70,
                          // height: 70,
                          imageUrl: "${APIEndPoint.serverURL}${item?.gallery}",
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        " ${item?.title}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${item?.price}",
                        style: TextStyle(color: Colors.pink),
                      ),

                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.pink,
                          ),
                          label: Text(
                            "Rate",
                            style: TextStyle(color: Colors.pink),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
