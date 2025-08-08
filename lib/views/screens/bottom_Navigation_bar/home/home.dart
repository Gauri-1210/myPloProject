import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_plo/controller/home/home_controller.dart';
import 'package:my_plo/services/api_end_point.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _PartyState createState() => _PartyState();
}

class _PartyState extends State<Home> {
  int _selectedIndex = 0;
  bool isParty = true;
  // bool isVendor = false;
  void party() {
    setState(() {
      isParty = true;
      // isVendor = false;
    });
    Map requestData = {"type": "partySupply"};
    HomeController homeController = Provider.of<HomeController>(
      context,
      listen: false,
    );

    homeController.getUserHomeData(context: context, requestData: requestData);
  }

  void vendor() {
    setState(() {
      // isVendor = true;
      isParty = false;
    });
    Map requestData = {"type": "vendorService"};
    HomeController homeController = Provider.of<HomeController>(
      context,
      listen: false,
    );

    homeController.getUserHomeData(context: context, requestData: requestData);
  }

  void onCategoryTap() {}

  // final imageUrl =
  //     'https://www.sugar.org/wp-content/uploads/Birthday-Cake-1.png';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Map requestData = {"type": "partySupply"};
    HomeController homeController = Provider.of<HomeController>(
      context,
      listen: false,
    );

    homeController.getUserHomeData(context: context, requestData: requestData);

    // if (isVendor) {
    //   Map requestData = {"type": "vendorService"};
    //   HomeController homeController = Provider.of<HomeController>(
    //     context,
    //     listen: false,
    //   );

    //   homeController.getUserHomeData(
    //     context: context,
    //     requestData: requestData,
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Provider.of<HomeController>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.location_on),
        title: Text("Search by location"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/notifications");
            },
            icon: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search",
                suffixIcon: Icon(Icons.search),
                fillColor: Colors.grey.shade200,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    party();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isParty ? Colors.white : Colors.grey.shade300,
                      border: Border.all(
                        color: isParty ? Colors.pink : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Party Supplies",
                      style: TextStyle(
                        color: isParty ? Colors.pink : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    vendor();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isParty ? Colors.grey.shade300 : Colors.white,
                      border: Border.all(
                        color: isParty ? Colors.black : Colors.pink,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Vendor Services",
                      style: TextStyle(
                        color: isParty ? Colors.black : Colors.pink,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          Expanded(
            child: Consumer<HomeController>(
              builder: (context, value, child) {
                return GridView.builder(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  itemCount: homeController.homeScreenCategory.length,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final item = homeController.homeScreenCategory[index];

                    return Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: isParty
                                    ? BorderRadius.circular(12)
                                    : null,

                                shape: isParty
                                    ? BoxShape.rectangle
                                    : BoxShape.circle,
                              ),
                            ),

                            Positioned(
                              top: 3,
                              left: 3,
                              child: Container(
                                height: 75,
                                width: 75,
                                child: isParty
                                    ? GestureDetector(
                                        onTap: () {
                                          Map partyData = {
                                            "type": "partySupply",
                                            "categoryIds": [item.id],
                                          };
                                          print(" ${partyData}");
                                          homeController.getCategoryProductData(
                                            context: context,
                                            requestData: partyData,
                                          );
                                        },

                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),

                                          child: CachedNetworkImage(
                                            // width: 70,
                                            // height: 70,
                                            imageUrl:
                                                "${APIEndPoint.serverURL}${item.image}",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          Map vendorSubCategory = {
                                            "categoryId": [item.id],
                                          };
                                          print(vendorSubCategory);
                                          homeController
                                              .getsubcategorybycategoryId(
                                                context: context,
                                                requestData: vendorSubCategory,
                                              );
                                        },
                                        child: CircleAvatar(
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                "${APIEndPoint.serverURL}${item.image}",
                                              ),
                                          radius: 35,
                                          onBackgroundImageError:
                                              (exception, stackTrace) =>
                                                  Icon(Icons.error),
                                        ),
                                      ),
                                // child: ClipRRect(
                                //   borderRadius: BorderRadius.circular(12),
                                //   child: CachedNetworkImage(
                                //     // width: 70,
                                //     // height: 70,
                                //     imageUrl: imageUrl,
                                //     fit: BoxFit.cover,
                                //     placeholder: (context, url) =>
                                //         Center(child: CircularProgressIndicator()),
                                //     errorWidget: (context, url, error) =>
                                //         Icon(Icons.error),
                                //   ),
                                // ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),
                        Text(
                          item.categoryName!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
