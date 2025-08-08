import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_plo/controller/auth/auth.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/userloginornot",
        (route) => false,
      );

      // if (mounted) {
      //   context.read<AuthController>().isUserAlreadyLoggedIn(context);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: Image.asset(
                'assets/images/my plo 1.png',
                color: Colors.white,
              ),
            ),
            Text(
              "The Genuis Way to Buy & Sell Party LeftOvers",
              style: TextStyle(color: Colors.white),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamedAndRemoveUntil(
            //       context,
            //       "/loginscreen",
            //       (route) => false,
            //     );
            //   },
            //   child: Text("Get Started"),
            // ),
          ],
        ),
      ),
    );
  }
}
