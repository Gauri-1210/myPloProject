import 'package:flutter/material.dart';
import 'package:my_plo/controller/auth/auth.dart';
import 'package:my_plo/core/constants/appconstants.dart';
import 'package:my_plo/theme/texttheme/textstyle_theme.dart';
import 'package:my_plo/views/widgets/back.dart';
import 'package:my_plo/views/widgets/button.dart';
import 'package:provider/provider.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<ForgotScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailcontroller = TextEditingController();
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

  void onTap() {}
  void onback() {
    Navigator.pop(context);
  }

  void forgotPassword() {
    if (_formKey.currentState!.validate()) {
      // Navigator.pushNamed(context, "/bottomnavigation");

      Map forgotemaildata = {"email": _emailcontroller.text};
      AuthController authController = Provider.of<AuthController>(
        context,
        listen: false,
      );
      authController.forgotpassword(forgotemaildata);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Back.buildBack(onback)),
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
                  "Forgot Password",
                  style: AppTheme.bold(),
                  // TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),

                Text(
                  "Forgot your Password? let's get you back in!",
                  style: AppTheme.base(),
                  // TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      },
                    ),
                  ),
                  SizedBox(height: 20),

                  Column(
                    children: [
                      Button.buildButton("Send OTP", forgotPassword),
                      // GestureDetector(
                      //   onTap: () {},
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
                      //         "Send OTP",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 20),
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
