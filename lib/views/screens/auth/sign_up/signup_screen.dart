import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_plo/controller/auth/auth.dart';
import 'package:my_plo/core/constants/appconstants.dart';
import 'package:my_plo/theme/texttheme/textstyle_theme.dart';
import 'package:my_plo/views/widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool state = true;
  bool state1 = false;
  bool state2 = false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void changePasswordState() {
    setState(() {
      if (state == false) {
        state = true;
      } else {
        state = false;
      }
    });
  }

  void onTap() {
    if (_formKey.currentState!.validate()) {
      if ((state1 == false) & (state2 == false)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please select the role ")));
      } else {
        ventor_user();
        // Map signupdata = {
        //   "email": _email.text.trim(),
        //   "password": _password.text.trim(),
        //   "fullName": _name.text.trim(),
        //   "fcmToken": "",
        //   "role": role,
        //   "userName": _username.text.trim(),
        // };
        // AuthController authController = Provider.of<AuthController>(
        //   context,
        //   listen: false,
        // );
        // // authController.userSignUpData = signupdata;
        // if (mounted) {
        //   authController.userSignup(signupdata, context);
        // }

        bottom();
      }
    }
  }

  String role = "";
  void ventor_user() {
    setState(() {
      if (state1 == true) {
        role = "User";
      }
      if (state2 == true) {
        role = "Vendor";
      }
    });
  }

  // void values() {
  //   Map value = {
  //     "email": _email.text,
  //     "password": _password.text,
  //     "name": _name.text,
  //     "username": _username.text,
  //     "role": role,
  //   };
  // }

  void _onTerms() async {
    final Uri url = Uri.parse('https://myplo.com/pages/terms-and-conditions');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void oncontinue() {
    Map signupdata = {
      "email": _email.text.trim(),
      "password": _password.text.trim(),
      "fullName": _name.text.trim(),
      "fcmToken": "",
      "role": role,
      "userName": _username.text.trim(),
    };
    // Navigator.pushNamed(context, "/bottomnavigation");
    AuthController authController = Provider.of<AuthController>(
      context,
      listen: false,
    );
    // authController.userSignUpData = signupdata;
    if (mounted) {
      authController.userSignup(signupdata, context);
    }
  }

  void onCancel() {
    Navigator.pop(context);
  }

  void bottom() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: LinearBorder(),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("By Clicking Sign Up , I agree that "),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.pink, size: 10),
                    Text(" I have Read and Accepted the "),
                    GestureDetector(
                      onTap: () {
                        _onTerms();
                      },
                      child: Text(
                        "Terms Of Use",
                        style: TextStyle(color: Colors.pink),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.pink, size: 10),
                    Text(" See Our "),
                    GestureDetector(
                      onTap: () {
                        _onTerms();
                      },
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(color: Colors.pink),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Button.buildButton("Cancel", onCancel)),
                    SizedBox(width: 10),
                    Expanded(child: Button.buildButton("Continue", oncontinue)),
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
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 110),
                child: Image.asset('assets/images/my plo 1.png'),
              ),
              Text(
                "The Genuis Way to Buy & Sell Party LeftOvers",
                style: AppTheme.normal(),
                // TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.all(AppConstants.apphorizontal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up",
                  style: AppTheme.bold(),
                  //  TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),

                Text(
                  "Join Us Today and start your Journey",
                  style: AppTheme.base(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Focus(
                    child: TextFormField(
                      controller: _name,

                      decoration: InputDecoration(
                        label: Text("Name"),
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
                    child: TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        label: Text("Email"),
                        fillColor: const Color.fromARGB(255, 223, 223, 223),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return "Enter Valid Email";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Focus(
                    child: TextFormField(
                      controller: _username,
                      decoration: InputDecoration(
                        label: Text("UserName"),
                        fillColor: const Color.fromARGB(255, 223, 223, 223),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the UserName";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Focus(
                    child: TextFormField(
                      controller: _password,
                      decoration: InputDecoration(
                        labelText: "Password",

                        suffixIcon: GestureDetector(
                          onTap: () {
                            changePasswordState();
                          },
                          child: Icon(
                            state
                                ? Icons.visibility_off
                                : Icons.visibility_outlined,
                          ),
                        ),
                        fillColor: const Color.fromARGB(255, 225, 225, 225),
                        filled: true,

                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },

                      obscureText: state,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // state1 = !state1;
                                if ((state1 == false) & (state2 == false)) {
                                  state1 = true;
                                } else if ((state1 == false) &
                                    (state2 == true)) {
                                  // state1 = false;
                                  (state1 = true) & (state2 = false);
                                } else {
                                  state1 = false;
                                }
                              });
                            },

                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: state1 ? Colors.pink : Colors.blueGrey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 90,
                              width: 160,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/Group (17).png',
                                    height: 40,
                                  ),
                                  SizedBox(height: 7),
                                  Text("User"),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    // state1 = !state1;
                                    if ((state1 == false) & (state2 == false)) {
                                      state1 = true;
                                    } else if ((state1 == false) &
                                        (state2 == true)) {
                                      // state1 = false;
                                      (state1 = true) & (state2 = false);
                                    } else {
                                      state1 = false;
                                    }
                                  });
                                },
                                icon: Icon(
                                  color: Colors.pink,
                                  state1 ? Icons.check_circle : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // state2 = !state2;
                                if ((state2 == false) & (state1 == false)) {
                                  state2 = true;
                                } else if ((state2 == false) &
                                    (state1 == true)) {
                                  (state2 = true) & (state1 = false);
                                } else {
                                  state2 = false;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: state2 ? Colors.pink : Colors.blueGrey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 90,
                              width: 160,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/Group (18).png',
                                    height: 40,
                                  ),
                                  SizedBox(height: 7),
                                  Text("Vendor"),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    // state2 = !state2;
                                    if ((state2 == false) & (state1 == false)) {
                                      state2 = true;
                                    } else if ((state2 == false) &
                                        (state1 == true)) {
                                      // state2 = false;
                                      (state2 = true) & (state1 = false);
                                    } else {
                                      state2 = false;
                                    }
                                  });
                                },
                                icon: Icon(
                                  color: Colors.pink,
                                  state2 ? Icons.check_circle : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Button.buildButton("Sign Up", onTap),
                      // GestureDetector(
                      //   onTap: () {},
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
                      //         "Sign Up",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an Account?  ",
                            style: AppTheme.base(),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                "/loginscreen",
                                (route) => false,
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                        ],
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
  }
}
