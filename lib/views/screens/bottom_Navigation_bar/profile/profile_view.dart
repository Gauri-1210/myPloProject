import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_plo/controller/auth/auth.dart';
import 'package:my_plo/controller/profile/profile_controller.dart';
import 'package:my_plo/services/api_end_point.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/payment/payout.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/profile/offers.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/profile/order.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/profile/sells.dart';

import 'package:my_plo/views/widgets/button.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<ProfileView> {
  void onButtonTap() {
    Navigator.pushNamed(context, "/editProfile");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map requestData = {};
    ProfileController profileController = Provider.of<ProfileController>(
      context,
      listen: false,
    );
    profileController.getUserData(context: context, requestData: requestData);
  }

  void onlogout() {
    // AuthController authController = Provider.of<AuthController>(
    //   context,
    //   listen: false,
    // );
    // authController.userlogout(context);
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/loginscreen",
      (route) => false,
    );
  }

  void onTap() {
    Navigator.pop(context);
  }

  void bottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),

            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        onTap();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: Colors.purple,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Logout from your Account?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: Button.buildButton("Cancel", onTap)),
                    SizedBox(width: 15),
                    Expanded(child: Button.buildButton("Logout", onlogout)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Provider.of<ProfileController>(
      context,
      listen: false,
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,

          title: Text("Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),

          child: Column(
            children: [
              Divider(),
              Container(
                child: Consumer<ProfileController>(
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            bottomSheet();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 25,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Logout ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(Icons.logout, color: Colors.white),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 120,
                          width: 120,

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),

                            child: CachedNetworkImage(
                              // width: 70,
                              // height: 70,
                              imageUrl:
                                  "${APIEndPoint.serverURL}${profileController.userProfileDataList?.avatar}",
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          // CircleAvatar(
                          //   backgroundImage: AssetImage("assets/images/profile.jpg"),
                          //   radius: 50,
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                profileController
                                        .userDataList
                                        ?.userData
                                        ?.fullName ??
                                    "",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star, color: Colors.amber),

                                  Text(
                                    " ${profileController.userDataList?.userData?.averageRating}",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.email_outlined, color: Colors.pink),
                                Text(
                                  " ${profileController.userDataList?.userData?.email}",
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                if (profileController
                                        .userDataList
                                        ?.userData
                                        ?.status !=
                                    true) {
                                  profileController.verifyMailRequest(context, {
                                    "email":
                                        profileController
                                            .userDataList
                                            ?.userData
                                            ?.email ??
                                        "",
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 25,
                                  width: 100,

                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      profileController
                                                  .userDataList
                                                  ?.userData
                                                  ?.status ==
                                              true
                                          ? "Verified Email"
                                          : "Verify Email",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${profileController.userDataList?.sellingProducts?.length}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("Listing"),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "${profileController.userDataList?.soldProducts?.length}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("Sold"),
                              ],
                            ),
                            // Column(
                            //   children: [
                            //     Text(
                            //       "${profileController.userDataList?.userData?.averageRating}",
                            //       style: TextStyle(fontWeight: FontWeight.bold),
                            //     ),
                            //     Text("Rating"),
                            //   ],
                            // ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Button.buildButton("Edit Profile", onButtonTap),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.pushNamed(context, "/editProfile");
                        //   },
                        //   child: Container(
                        //     height: 45,
                        //     width: double.infinity,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.rectangle,
                        //       borderRadius: BorderRadius.circular(25),
                        //       border: Border.all(color: Colors.black),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "Edit Profile",
                        //         style: TextStyle(
                        //           color: Colors.pink,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Button.buildButton(
                          "Edit Profile",
                          onButtonTap,

                          isborder: true,
                          border: 0xFFFFC0CB,
                          linear1: Colors.white,
                          linear2: Colors.white,
                          isbg: false,
                          istext: false,
                        ),
                      ],
                    );
                  },
                ),
              ),
              TabBar(
                isScrollable: true,

                tabs: [
                  Tab(text: "My Listing"),
                  Tab(text: "My Purchases"),
                  // Tab(text: "Offers"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    OrderScreen(), SellsScreen(),
                    // OffersScreen()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
