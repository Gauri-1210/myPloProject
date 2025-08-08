import 'package:flutter/material.dart';
import 'package:my_plo/controller/auth/auth.dart';

import 'package:my_plo/core/constants/appconstants.dart';

import 'package:my_plo/theme/texttheme/textstyle_theme.dart';
import 'package:my_plo/views/widgets/button.dart';
import 'package:my_plo/views/widgets/dialog/alert_dialog.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool state = true;
  void changePasswordState() {
    setState(() {
      if (state == false) {
        state = true;
      } else {
        state = false;
      }
    });
  }

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  void userLogin() {
    if (_formKey.currentState!.validate()) {
      final requestData = {
        "email": _emailcontroller.text,
        "password": _passwordcontroller.text,
      };

      final authController = Provider.of<AuthController>(
        context,
        listen: false,
      );

      authController.login(requestData: requestData, context: context);
    }
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
              ),
            ],
          ),
          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Log In",
                  style: AppTheme.bold(),
                  // TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),

                Text(
                  "Login Up with one of the following options",
                  style: AppTheme.base(),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.apphorizontal,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Focus(
                    child: TextFormField(
                      controller: _emailcontroller,
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
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Focus(
                    child: Consumer<AuthController>(
                      builder: (context, value, child) {
                        return TextFormField(
                          controller: _passwordcontroller,
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
                            // enabledBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.black),
                            //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            // ),
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
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Button.buildButton("Log In", userLogin),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pushNamed(context, "/locationscreen");
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
                      //         "Log In",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/forgotscreen");
                            },
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(color: Colors.pinkAccent),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?  ",
                            style: AppTheme.base(),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                "/signUpscreen",
                                (route) => false,
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.pinkAccent),
                            ),
                          ),

                          // InkWell(
                          //   onTap: () {
                          //     Navigator.pushNamed(context, "/forgotscreen");
                          //   },
                          //   child: Text(
                          //     "Forgot Password",
                          //     style: TextStyle(color: Colors.pinkAccent),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(25),
                            color: Color.fromARGB(255, 225, 225, 225),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/Google.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text("  Continue with Google"),
                                ],
                              ),
                            ],
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
  }
}
