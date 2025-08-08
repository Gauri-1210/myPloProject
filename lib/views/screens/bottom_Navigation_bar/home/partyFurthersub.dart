import 'package:flutter/material.dart';
import 'package:my_plo/controller/home/home_controller.dart';
import 'package:my_plo/core/constants/utils/date_format/date_format.dart';
import 'package:my_plo/services/api_end_point.dart';
import 'package:my_plo/views/widgets/back.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Partyfurthersub extends StatefulWidget {
  const Partyfurthersub({super.key});
  @override
  _PartyFurtherState createState() => _PartyFurtherState();
}

class _PartyFurtherState extends State<Partyfurthersub> {
  // final List<Map<String, dynamic>> items = [

  //   {
  //     "Name": "Baby Shower",
  //     "Time": "22 hours Ago",
  //     "Price": "\$899",
  //     "State": "Karnataka, India",
  //   },
  //   {
  //     "Name": "Baby Shower",
  //     "Time": "22 hours Ago",
  //     "Price": "\$899",
  //     "State": "Karnataka, India",
  //   },
  //   {
  //     "Name": "Baby Shower",
  //     "Time": "22 hours Ago",
  //     "Price": "\$899",
  //     "State": "Karnataka, India",
  //   },
  //   {
  //     "Name": "Baby Shower",
  //     "Time": "22 hours Ago",
  //     "Price": "\$899",
  //     "State": "Karnataka, India",
  //   },
  //   {
  //     "Name": "Baby Shower",
  //     "Time": "22 hours Ago",
  //     "Price": "\$899",
  //     "State": "Karnataka, India",
  //   },
  //   {
  //     "Name": "Baby Shower",
  //     "Time": "22 hours Ago",
  //     "Price": "\$899",
  //     "State": "Karnataka, India",
  //   },
  //   {
  //     "Name": "Baby Shower",
  //     "Time": "22 hours Ago",
  //     "Price": "\$899",
  //     "State": "Karnataka, India",
  //   },
  //   {
  //     "Name": "Baby Shower",
  //     "Time": "22 hours Ago",
  //     "Price": "\$899",
  //     "State": "Karnataka, India",
  //   },
  //   {
  //     "Name": "Baby Shower",
  //     "Time": "22 hours Ago",
  //     "Price": "\$899",
  //     "State": "Karnataka, India",
  //   },
  //   {
  //     "Name": "Baby Shower",
  //     "Time": "22 hours Ago",
  //     "Price": "\$899",
  //     "State": "Karnataka, India",
  //   },
  //   {
  //     "Name": "Baby Shower",
  //     "Time": "22 hours Ago",
  //     "Price": "\$899",
  //     "State": "Karnataka, India",
  //   },
  //   {
  //     "Name": "Baby Shower",
  //     "Time": "22 hours Ago",
  //     "Price": "\$899",
  //     "State": "Karnataka, India",
  //   },
  // ];

  void onback() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Provider.of<HomeController>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        leading: Back.buildBack(onback),
        title: Center(
          child: Text(
            "Part Supplies",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: homeController.categoryProductData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 0,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final item = homeController.categoryProductData[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/sliderView");
              print("item id  ${item.id}");
              homeController.categorySingleProductData = item;
              print(homeController.categorySingleProductData);
            },
            child: Column(
              // scrollDirection: Axis.vertical,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusGeometry.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),

                            // image: DecorationImage(
                            //    image: item.gallery!.isNotEmpty ? "${APIEndPoint.serverURL}${item.gallery![0]}"

                            // fit: BoxFit.cover,
                          ),
                          child: item.gallery!.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),

                                  child: CachedNetworkImage(
                                    // width: 70,
                                    // height: 70,
                                    imageUrl:
                                        "${APIEndPoint.serverURL}${item.gallery![0]}",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(12),

                                  child: Icon(Icons.error),
                                ),

                          // child:
                          //   Image.asset(
                          //     'assets/images/babyshower.jpg',
                          //     height: 110,
                          //     fit: BoxFit.fill,
                          //   ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Container(
                                width: 60,
                                child: Text(
                                  item.title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                "\$ ${item.price}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Container(
                                width: 60,
                                child: Text(
                                  DateFormater.formateDate(
                                    item.createdAt.toString(),
                                  ),

                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Container(
                                width: 80,
                                child: Text(
                                  item.location!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,

                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
