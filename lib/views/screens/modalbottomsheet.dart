import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:my_plo/controller/home/home_controller.dart';
import 'package:my_plo/views/widgets/button.dart';
import 'package:provider/provider.dart';

class Modalbottomsheet extends StatefulWidget {
  const Modalbottomsheet({super.key});
  @override
  _ModalState createState() => _ModalState();
}

class _ModalState extends State<Modalbottomsheet> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController country = TextEditingController(text: "United States");
  TextEditingController states = TextEditingController();
  TextEditingController city = TextEditingController();
  bool state = false;
  void changePasswordState() {
    setState(() {
      if (state == false) {
        state = true;
      } else {
        state = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onButtonTap() {
    if (_formKey.currentState!.validate()) {
      Map requestData = {
        "name": name.text,
        "country": "United States",
        "address1": address1.text,
        "address2": address2.text,
        "city": city.text,
        "state": states.text,
        "zipcode": zipcode.text,
        "phone": phoneNumber.text,
      };
      print(requestData);
      HomeController homeController = Provider.of<HomeController>(
        context,
        listen: false,
      );
      homeController.addaddress(context, requestData);
    }
  }

  // String selectedvalue1 = "Select Country";
  // List<String> condition = ['Select Country', 'India', 'Japan', 'USA'];
  // String selectedvalue2 = "Select State";
  // List<String> states = ['Select State', 'Maharashtra', 'Tokyo', 'California'];
  // String selectedvalue3 = "Select City";
  // List<String> city = ['Select City', 'Mumbai', 'Osaka', 'Los Angeles'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 25)),
              Text("Add Shipping Address", style: TextStyle(fontSize: 18)),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          Divider(),

          // ListTile(
          //   title: Text("Student"),
          //   trailing: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Icon(Icons.close),
          //   ),
          // ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Focus(
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      hint: Text("Name *"),

                      fillColor: const Color.fromARGB(255, 225, 225, 225),

                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.black),
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your Name";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Focus(
                  child: TextFormField(
                    controller: country,

                    decoration: InputDecoration(
                      hintText: 'United States',
                      enabled: false,

                      labelText: "Country",

                      fillColor: const Color.fromARGB(255, 225, 225, 225),
                      filled: true,

                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter the Address";
                      }
                    },
                  ),
                ),

                // DropdownButtonFormField<String>(
                //   value: country.text,
                //   decoration: InputDecoration(
                //     fillColor: const Color.fromARGB(255, 225, 225, 225),
                //     filled: true,

                //     // enabledBorder: OutlineInputBorder(
                //     //   borderSide: BorderSide(color: Colors.black),
                //     //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //     // ),
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide.none,
                //       borderRadius: BorderRadius.circular(25),
                //     ),
                //   ),
                //   items: condition.map((String condition) {
                //     return DropdownMenuItem<String>(
                //       value: condition,
                //       child: Text(condition),
                //     );
                //   }).toList(),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       selectedvalue1 = newValue!;
                //     });
                //   },
                // ),
                SizedBox(height: 16),
                Focus(
                  child: TextFormField(
                    controller: address1,
                    decoration: InputDecoration(
                      labelText: "Address 1 *",

                      fillColor: const Color.fromARGB(255, 225, 225, 225),
                      filled: true,

                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter the Address";
                      }
                    },
                  ),
                ),
                SizedBox(height: 16),
                Focus(
                  child: TextFormField(
                    controller: address2,

                    decoration: InputDecoration(
                      labelText: "Address 2 *",

                      fillColor: const Color.fromARGB(255, 225, 225, 225),
                      filled: true,

                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // DropdownButtonFormField<String>(
                //   value: selectedvalue2,
                //   decoration: InputDecoration(
                //     fillColor: const Color.fromARGB(255, 225, 225, 225),
                //     filled: true,

                //     // enabledBorder: OutlineInputBorder(
                //     //   borderSide: BorderSide(color: Colors.black),
                //     //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //     // ),
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide.none,
                //       borderRadius: BorderRadius.circular(25),
                //     ),
                //   ),
                //   items: states.map((String states) {
                //     return DropdownMenuItem<String>(
                //       value: states,
                //       child: Text(states),
                //     );
                //   }).toList(),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       selectedvalue2 = newValue!;
                //     });
                //   },
                // ),
                // SizedBox(height: 16),
                // DropdownButtonFormField<String>(
                //   value: selectedvalue3,
                //   decoration: InputDecoration(
                //     fillColor: const Color.fromARGB(255, 225, 225, 225),
                //     filled: true,

                //     // enabledBorder: OutlineInputBorder(
                //     //   borderSide: BorderSide(color: Colors.black),
                //     //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //     // ),
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide.none,
                //       borderRadius: BorderRadius.circular(25),
                //     ),
                //   ),
                //   items: city.map((String city) {
                //     return DropdownMenuItem<String>(
                //       value: city,
                //       child: Text(city),
                //     );
                //   }).toList(),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       selectedvalue3 = newValue!;
                //     });
                //   },
                // ),
                SizedBox(height: 16),
                Focus(
                  child: TextFormField(
                    controller: zipcode,
                    decoration: InputDecoration(
                      labelText: 'Pincode *',
                      border: UnderlineInputBorder(),

                      fillColor: const Color.fromARGB(255, 225, 225, 225),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),

                      // errorText: "Enter valid email address",
                      // errorBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.pink),
                      // ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter the Pincode";
                      }
                    },

                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                  ),
                ),
                SizedBox(height: 16),
                Focus(
                  child: TextFormField(
                    controller: phoneNumber,
                    keyboardType: TextInputType.phone,

                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: "Phone Number *",

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
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter the Phone Number";
                      }
                    },
                  ),
                ),
                CountryStateCityPicker(
                  country: country,
                  state: states,
                  city: city,
                  dialogColor: Colors.grey.shade200,
                  textFieldDecoration: InputDecoration(
                    fillColor: Colors.blueGrey.shade100,
                    filled: true,
                    suffixIcon: const Icon(Icons.arrow_downward_rounded),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          Button.buildButton("Add Address", onButtonTap),
        ],
      ),
    );
  }
}
