import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:my_plo/controller/auth/addproduct/addproduct_controller.dart';
import 'package:my_plo/controller/home/home_controller.dart';
import 'package:my_plo/model/addProduct_model/activecategories_model.dart';
import 'package:my_plo/services/api_end_point.dart';
import 'package:my_plo/views/widgets/button.dart';
import 'package:my_plo/views/widgets/dialog/alert_dialog.dart';
import 'package:my_plo/views/widgets/location/geolocator.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  const Products({super.key});
  @override
  _Products createState() => _Products();
}

// enum size { Small, Medium, Large }

class _Products extends State<Products> {
  final _formKey = GlobalKey<FormState>();
  String selectedvalue = "";
  String _sizeItem = "";

  // String _selectedSize = "Small";

  // List<String> category = [
  //   'Choose Product Category',
  //   'Birthday',
  //   'Anniversary',
  //   'Baby Shower',
  // ];
  String selectedvalue1 = "Condition";
  List<String> condition = ['Condition', 'Excellent', 'Good', 'Poor'];
  // size? _sizeItem = size.Small;
  List<XFile> images = [];
  final ImagePicker _picker = ImagePicker();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  // final controller = MultiImagePickerController(
  //   maxImages: 10,
  //   picker: (int count, Object? params) async {
  //     final picker = ImagePicker();
  //     final images = await picker.pickMultiImage();
  //     return images.map((img) => convertXFileToImageFile(img)).toList();
  //   },
  // );
  Future<void> _pickImages() async {
    final List<XFile> pickedimages = await _picker.pickMultiImage();

    setState(() {
      images.addAll(pickedimages);
    });
  }

  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
    AddproductController addproductController =
        Provider.of<AddproductController>(context, listen: false);
    Map requestData = {};
    addproductController.getshippingSize(
      context: context,
      requestData: requestData,
    );
  }

  Future<void> _initializeData() async {
    // Get current location
    Position position = await Geolocation.getCurrentLocation();
    double longitude = position.longitude;
    double latitude = position.latitude;
    print("Latitude: ${position.latitude}");
    print("Longitude: ${position.longitude}");
  }

  TextEditingController searchController = TextEditingController();
  List<dynamic> placesList = [];
  Future<void> searchPlaces(String input) async {
    print("Search $input");
    final String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${APIEndPoint.googleApiKey}&types=geocode&components=country:US";

    final response = await http.get(Uri.parse(url));
    print(placesList);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["status"] == "OK") {
        setState(() {
          placesList = data["predictions"];
        });
      }
    } else {
      print("Error fetching places: ${response.body}");
    }
  }

  onTapp() {
    AlertDialogBox.showSnackBar(
      "Please verify your email in the Profile section to sell products.",
      context,
    );
  }

  onButtonTap() async {
    if (images.isEmpty) {
      AlertDialogBox.showSnackBar("Please Select the images", context);
    } else if (_sizeItem == "") {
      AlertDialogBox.showSnackBar("Please select the Sizes", context);
    } else if (searchController.text == "") {
      AlertDialogBox.showSnackBar("Please Select the Location", context);
    } else if (selectedvalue == "") {
      AlertDialogBox.showSnackBar("Please select the category", context);
    } else if (_formKey.currentState!.validate()) {
      List sendItToBackend = [];

      for (int i = 0; i < images.length; i++) {
        sendItToBackend.add({"key": "gallery", "path": images[i].path});
      }

      print(sendItToBackend);

      Map<String, String> values = {
        "title": titleController.text,
        "description": descriptionController.text,
        "price": priceController.text,
        // "latitude": latitude,
        // "longitude": longitude,
        "categoryId": selectedvalue,
        "location": searchController.text,
        "status": "true",
        "type": "partySupply",
        "condition": selectedvalue1,
        "shippingSizeId": _sizeItem,
      };
      print(values);

      AddproductController addproductController =
          Provider.of<AddproductController>(context, listen: false);
      addproductController.addProduct(context, values, sendItToBackend);
    } else {
      AlertDialogBox.showSnackBar(
        "Please Fill All the required Fields",
        context,
      );
    }
    // Position position = await Geolocation.getCurrentLocation();
    // double longitude = position.longitude;
    // double latitude = position.latitude;
  }

  @override
  Widget build(BuildContext context) {
    AddproductController addproductController =
        Provider.of<AddproductController>(context, listen: false);
    HomeController homeController = Provider.of<HomeController>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Add Product")),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          homeController.isEmailVerified
              ? SizedBox()
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(color: Color(0xFFFFE7EA)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.info, color: Color(0xFFFF6174)),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                "Please verify your email in the Profile section to sell products.",
                                style: TextStyle(color: Color(0xFFFF6174)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ...List.generate(images.length, (index) {
                return Stack(
                  children: [
                    Image.file(
                      height: 75,
                      width: 75,
                      fit: BoxFit.cover,
                      File(images[index].path),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _removeImage(index),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.close, size: 14, color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              GestureDetector(
                onTap: _pickImages,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.add_photo_alternate,
                    size: 30,
                    color: Colors.pink,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedvalue,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          fillColor: const Color.fromARGB(255, 225, 225, 225),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        items: [
                          DropdownMenuItem<String>(
                            value: "",
                            child: Text("Select Category"),
                          ),
                          ...addproductController.productCategories.map((
                            category,
                          ) {
                            return DropdownMenuItem<String>(
                              value: category.id,
                              child: Text(category.categoryName ?? ""),
                            );
                          }),
                        ],

                        onChanged: (String? newValue) {
                          setState(() {
                            selectedvalue = newValue!;
                          });
                        },
                      ),

                      SizedBox(height: 20),
                      Focus(
                        child: TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                            label: Text("Product Title"),
                            fillColor: const Color.fromARGB(255, 223, 223, 223),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter the Name";
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Focus(
                        child: Container(
                          height: 80,
                          child: TextFormField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                              label: Text("Description"),
                              fillColor: const Color.fromARGB(
                                255,
                                223,
                                223,
                                223,
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 40,
                                horizontal: 15,
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Description";
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Focus(
                        child: TextFormField(
                          controller: priceController,
                          decoration: InputDecoration(
                            label: Text("Price"),
                            fillColor: const Color.fromARGB(255, 223, 223, 223),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter the Price";
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: searchController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            searchPlaces(value);
                          } else {
                            setState(() {
                              placesList = [];
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Search location...",
                          fillColor: const Color.fromARGB(255, 223, 223, 223),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      placesList.isEmpty
                          ? SizedBox()
                          : SizedBox(
                              height: 150,
                              child: ListView.builder(
                                itemCount: placesList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      placesList[index]["description"],
                                    ),
                                    onTap: () {
                                      searchController.text =
                                          placesList[index]["description"];
                                      setState(() {
                                        placesList = [];
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedvalue1,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 225, 225, 225),
                          filled: true,

                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.black),
                          //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          // ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        items: condition.map((String condition) {
                          return DropdownMenuItem<String>(
                            value: condition,
                            child: Text(condition),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedvalue1 = newValue!;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      // GestureDetector(
                      //   onTap: () {
                      //     // Navigator.pushNamed(context, "/editProfile");
                      //   },
                      //   child: Container(
                      //     height: 60,
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.rectangle,
                      //       borderRadius: BorderRadius.circular(25),
                      //       gradient: LinearGradient(
                      //         colors: [Colors.blue, Colors.purple],
                      //       ),
                      //     ),
                      //     child: Center(
                      //       child: Text(
                      //         "Edit Profile",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            "Select Product Shipping Size and weight",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  ...addproductController.shippingSize.map((sizes) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _sizeItem == sizes.name
                              ? Colors.pink
                              : Colors.grey,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: RadioListTile(
                        value: sizes.id ?? "",
                        groupValue: _sizeItem,
                        onChanged: (value) {
                          setState(() => _sizeItem = value!);
                          print(value);
                        },
                        title: Text("${sizes.name}"),
                        subtitle: Text(
                          "(Approx ${sizes.length} x ${sizes.width} x ${sizes.height} : ${sizes.weightValue} ${sizes.weightUnit})",
                        ),
                        secondary: CachedNetworkImage(
                          width: 70,
                          height: 70,
                          imageUrl: "${APIEndPoint.serverURL}${sizes.image}",
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    );
                  }),
                ],
              ),

              SizedBox(height: 20),
              (homeController.isEmailVerified)
                  ? Button.buildButton("Add Product", onButtonTap)
                  : Button.buildButton("Add Product", onTapp),

              // GestureDetector(
              //               onTap: () {
              //                 showSnackBar(
              //                     "Please verify your email in the Profile section to sell products.");
              //               },
              //               child: Container(
              //                 height: CommonTheme.btnHeight,
              //                 decoration: BoxDecoration(
              //                   color: Colors.grey,
              //                   borderRadius: BorderRadius.circular(
              //                       CommonTheme.borderRadius),
              //                 ),
              //                 width: double.infinity,
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Center(
              //                     child: Text(
              //                       "Preview",
              //                       style: TextStyle(
              //                         color: Colors.white,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),

              //                   ),
              //                 ),
              //               ),
              //             ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/notifications');
              //   },
              //   child: Container(
              //     height: 60,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       shape: BoxShape.rectangle,
              //       borderRadius: BorderRadius.circular(25),
              //       gradient: LinearGradient(
              //         colors: [Colors.purple, Colors.blue],
              //       ),
              //     ),
              //     child: Center(
              //       child: Text(
              //         "Add Product",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 2,
      //   selectedItemColor: Colors.pink,
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
      //     BottomNavigationBarItem(icon: Icon(Icons.chat), label: "CHATS"),
      //     BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "SELL"),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_balance_wallet),
      //       label: "Payout",
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: "PROFILE"),
      //   ],
      // ),
    );
  }
}
