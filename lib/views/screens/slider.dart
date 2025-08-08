import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_plo/controller/home/home_controller.dart';
import 'package:my_plo/core/constants/appconstants.dart';
import 'package:my_plo/views/widgets/back.dart';
import 'package:my_plo/views/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/api_end_point.dart';

class SliderView extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<SliderView> {
  int currentIndex = 0;

  // final List<String> images = [
  //   'assets/images/babyshower.jpg',
  //   'assets/images/babyshower2.jpg',
  //   'assets/images/babyshower3.jpg',
  // ];
  bool state = false;
  void _changeState() {
    setState(() {
      if (state == false) {
        state = true;
      } else {
        state = false;
      }
    });
  }

  // void share() async {
  //   SharePlus.instance.share(
  //     ShareParams(text: "Check out my website https://example.com"),
  //   );
  // void share() async {
  //   final result = await SharePlus.instance.share(
  //     ShareParams(
  //       text:
  //           'Check out this product!\n\nOpen in browser: https://yourwebsite.com/product/123\n\nShare via email or Facebook!',
  //     ),
  //   );
  //   if (result.status == ShareResultStatus.success) {
  //     print('Thank you for sharing my website!');
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text('Thank you for sharing!')));
  //   }
  // }
  void sendSMS(String phone, String message) async {
    final Uri smsUri = Uri.parse(
      "sms:$phone?body=${Uri.encodeComponent(message)}",
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not launch SMS';
    }
  }

  void launchWhatsApp(String phone, String message) async {
    final Uri whatsappUri = Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent(message)}",
    );

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  void launchPhoneDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch dialer';
    }
  }

  void share() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'abc@example.com',
      query: _encodeQueryParameters({
        'subject': 'Product Inquiry',
        'body': 'I would like to know more about the product.',
      }),
    );

    if (!await launchUrl(emailUri)) {
      throw Exception('Could not launch email client');
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  void onback() {
    Navigator.pop(context);
  }

  void onMakeOffer() {
    final TextEditingController _controller = TextEditingController();
    String value = _controller.text;
    if (value.isNotEmpty) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Offer submitted successfully!")));
    }
  }

  void bottom() {
    final TextEditingController _controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),

            child: Column(
              children: [
                Text(
                  "Make an Offer",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 225, 225, 225),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      label: Text("Make an offer Price"),
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Button.buildButton("Offer Price", () {
                  String value = _controller.text;
                  if (value.isNotEmpty) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Offer submitted successfully!")),
                    );
                  }
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  // final result = await SharePlus.instance.share(params);

  // if (result.status == ShareResultStatus.success) {
  //     print('Thank you for sharing my website!');
  // }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Provider.of<HomeController>(
      context,
      listen: false,
    );
    final categoryitem = homeController.categorySingleProductData;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Slider"),
        leading: Back.buildBack(onback),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.apphorizontal),
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                InkWell(
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(20),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        height: 250,
                        autoPlay: true,
                        // enlargeCenterPage: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                      items: categoryitem!.gallery!.map((imgPath) {
                        return Builder(
                          builder: (BuildContext context) {
                            return CachedNetworkImage(
                              imageUrl: "${APIEndPoint.serverURL}$imgPath",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                        );
                        // Image.asset(
                        //   imgPath,
                        //   fit: BoxFit.cover,
                        //   width: double.infinity,
                        // );
                      }).toList(),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(categoryitem.gallery!.length, (
                      index,
                    ) {
                      return Container(
                        width: 10,
                        height: 10,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: currentIndex == index
                              ? BorderRadius.circular(4)
                              : null,
                          shape: currentIndex == index
                              ? BoxShape.rectangle
                              : BoxShape.circle,
                          color: currentIndex == index
                              ? Colors.red
                              : Colors.white54,
                        ),
                      );
                    }),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 7,
                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {
                        _changeState();
                      },
                      icon: Icon(
                        state ? Icons.favorite : Icons.favorite_border_outlined,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    categoryitem!.title!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  GestureDetector(
                    onTap: () {
                      sendSMS(
                        "9828725725",
                        "Thank You for choosing our website\n Do expore new things \n ",
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.pink, Colors.blue],
                        ),
                      ),
                      child: Icon(Icons.sms_rounded, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchWhatsApp(
                        "9828725725",
                        "Thank You for choosing our website\n Do expore new things \n Do let us know if you need any kind of help? \n We our always there to support and provide service to you",
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.pink, Colors.blue],
                        ),
                      ),
                      child: Icon(Icons.message, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchPhoneDialer("9461475335");
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.pink, Colors.blue],
                        ),
                      ),
                      child: Icon(Icons.phone, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      share();
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.pink, Colors.blue],
                        ),
                      ),
                      child: Icon(Icons.share, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "\$ ${categoryitem.price}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("${categoryitem.description}"),
                  ),
                ],
              ),
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.white,
            //           foregroundColor: Colors.black,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //         onPressed: () {
            //           bottom();
            //         },
            //         child: Text("Make an Offer"),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Expanded(
            //   child: Container(
            //     height: 50,

            //     decoration: BoxDecoration(
            //       color: const Color.fromARGB(255, 100, 99, 99),
            //     ),
            //     child: Align(
            //       alignment: Alignment.center,
            //       child: Text("Chat", style: TextStyle(color: Colors.white)),
            //     ),
            //   ),
            // ),
            Expanded(
              child: Container(
                height: 50,

                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.pink, Colors.blue]),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/shipping_payment");
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Buy Now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
