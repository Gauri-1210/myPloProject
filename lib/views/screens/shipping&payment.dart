import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_plo/controller/home/home_controller.dart';
import 'package:my_plo/controller/payment/payment_controller.dart';
import 'package:my_plo/core/constants/appconstants.dart';
import 'package:my_plo/services/api_end_point.dart';
import 'package:my_plo/views/screens/modalbottomsheet.dart';
import 'package:my_plo/views/widgets/back.dart';
import 'package:my_plo/views/widgets/dialog/alert_dialog.dart';
import 'package:provider/provider.dart';

class Shipping_payment extends StatefulWidget {
  const Shipping_payment({super.key});
  @override
  _ShippingPState createState() => _ShippingPState();
}

class _ShippingPState extends State<Shipping_payment> {
  void onback() {
    Navigator.pop(context);
  }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeController homeController = Provider.of(context, listen: false);

    homeController.getAvailableAddress(context);
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Provider.of<HomeController>(
      context,
      listen: false,
    );
    final categoryitem = homeController.categorySingleProductData;
    return Scaffold(
      appBar: AppBar(
        title: Text("Shipping & Payment"),
        leading: Back.buildBack(onback),
      ),

      body: Consumer<HomeController>(
        builder: (context, homeController, _) {
          return Column(
            children: [
              Expanded(
                child: ListView(
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
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${APIEndPoint.serverURL}${categoryitem?.gallery?[0]}",
                                fit: BoxFit.cover,
                                // width: double.infinity,
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
                                  Text(categoryitem!.title!),
                                  Text(
                                    "\$ ${categoryitem.price}",
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ...homeController.userAddress.map(
                              (address) => Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    for (var addr
                                        in homeController.userAddress) {
                                      addr.isSelected =
                                          false; // Unselect all addresses
                                    }
                                    address.isSelected = false;
                                    setState(() {
                                      address.isSelected = true;
                                    });
                                    Map requestData = {
                                      "productId": categoryitem.id,
                                      "shipToAddress": {
                                        "address_line1": "${address.address1}",
                                        "address_residential_indicator": "no",
                                        "city_locality": "${address.city}",
                                        "company_name": "Example Inc.",
                                        "country_code": "United States",
                                        "name": "${address.name}",
                                        "phone": "${address.phone}",
                                        "postal_code": "${address.zipcode}",
                                        "state_province": "${address.state}",
                                      },
                                    };
                                    log(
                                      "reques data ${json.encode(requestData)}",
                                    );
                                    homeController.getShippingCharges(
                                      context,
                                      requestData,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: address.isSelected
                                            ? Colors.red
                                            : Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Card(
                                      margin: EdgeInsets.all(0),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 5,
                                          top: 15,
                                          bottom: 15,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  // width:
                                                  //     MediaQuery.of(
                                                  //       context,
                                                  //     ).size.width /
                                                  //     2,
                                                  child: Text(
                                                    address.name ?? "",
                                                  ),
                                                ),
                                                SizedBox(
                                                  // width:
                                                  //     MediaQuery.of(
                                                  //       context,
                                                  //     ).size.width /
                                                  //     2,
                                                  child: Text(
                                                    address.address1 ?? "",
                                                  ),
                                                ),
                                                SizedBox(
                                                  // width:
                                                  //     MediaQuery.of(
                                                  //       context,
                                                  //     ).size.width /
                                                  //     2,
                                                  child: Text(
                                                    address.zipcode ?? "",
                                                  ),
                                                ),
                                                SizedBox(
                                                  // width:
                                                  //     MediaQuery.of(
                                                  //       context,
                                                  //     ).size.width /
                                                  //     2,
                                                  child: Text(
                                                    address.phone ?? "",
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                // InkWell(
                                                //   onTap: () {},
                                                //   child: Icon(
                                                //     Icons.edit,
                                                //     color: Colors.black,
                                                //   ),
                                                // ),
                                                SizedBox(width: 5),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            "Confirm Deletion",
                                                          ),
                                                          content: Text(
                                                            "Are you sure you want to delete this address?",
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                    context,
                                                                  ).pop(
                                                                    false,
                                                                  ), // Cancel
                                                              child: Text(
                                                                "Cancel",
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Map
                                                                requestData = {
                                                                  "id": address
                                                                      .id,
                                                                };
                                                                homeController
                                                                    .deleteAvailableAddress(
                                                                      context,
                                                                      requestData:
                                                                          requestData,
                                                                    );
                                                              }, // Confirm
                                                              child: Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Color(0xFFFF1616),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text("Gauri Goyal"),
                              //     Text("XYZ Street"),
                              //     Text("Near ABC road"),
                              //     Text("Rajasthan"),
                              //     Text("Jaipur"),
                              //     Text("302019"),
                              //     Text("9461475336"),
                              //   ],
                              // ),

                              // Column(
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Icon(Icons.edit),
                              //         Icon(Icons.delete, color: Colors.pink),
                              //       ],
                              //     ),
                              //   ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     height: 160,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //         color: const Color.fromARGB(255, 216, 215, 215),
                    //       ),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 10,
                    //         vertical: 8,
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text("Gauri Goyal"),
                    //               Text("XYZ Street"),
                    //               Text("Near ABC road"),
                    //               Text("Rajasthan"),
                    //               Text("Jaipur"),
                    //               Text("302019"),
                    //               Text("9461475336"),
                    //             ],
                    //           ),

                    //           Column(
                    //             children: [
                    //               Row(
                    //                 children: [
                    //                   Icon(Icons.edit),
                    //                   Icon(Icons.delete, color: Colors.pink),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showModalBottomsheet(context);
                            },
                            child: Row(
                              children: [
                                Text("Add New Address"),
                                Icon(Icons.add, color: Colors.pink),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Summary",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Item Fee",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("\$ ${categoryitem.price}"),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Shipping",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\$${homeController.calculateShippingRate}",
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order Total",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\$ ${categoryitem.price! + homeController.calculateShippingRate}",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        bool isAnyAddressSelected = homeController.userAddress
                            .any((addr) => addr.isSelected);
                        if (homeController.userAddress == []) {
                          AlertDialogBox.showSnackBar(
                            "Please add the address",
                            context,
                          );
                        }

                        if (isAnyAddressSelected) {
                          int selectedIndex = homeController.userAddress
                              .indexWhere((addr) => addr.isSelected);
                          Map requestData = {
                            "sellerId": categoryitem.userId,
                            "addressId":
                                homeController.userAddress[selectedIndex].id,
                            "shipping": homeController.calculateShippingRate,
                            "productId": categoryitem.id,
                            "total":
                                categoryitem.price! +
                                homeController.calculateShippingRate,
                            "productType": "user",
                          };
                          PaymentController paymentController = Provider.of(
                            context,
                            listen: false,
                          );
                          print(" pay ${requestData["total"]}");
                          paymentController.getStripPaymentToekn(
                            requestData: requestData,
                            context: context,
                            amount: requestData["total"],
                          );
                          print(requestData);
                          // Navigator.pushNamed(context, "/paymentMethod");
                        } else {
                          AlertDialogBox.showSnackBar(
                            "Please Select the addresss",
                            context,
                          );
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue, Colors.pink],
                              ),
                            ),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Proceed To Payment",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
