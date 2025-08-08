import 'package:flutter/material.dart';
import 'package:my_plo/controller/auth/auth.dart';
import 'package:my_plo/views/screens/auth/login/login_screen.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/bottomNavigationBar.dart';
import 'package:provider/provider.dart';

class IsUserLoggedInOrNot extends StatefulWidget {
  const IsUserLoggedInOrNot({super.key});

  @override
  State<IsUserLoggedInOrNot> createState() => _IsUserLoggedInOrNotState();
}

class _IsUserLoggedInOrNotState extends State<IsUserLoggedInOrNot> {
  @override
  Widget build(BuildContext context) {
    AuthController authController = Provider.of<AuthController>(
      context,
      listen: false,
    );
    return FutureBuilder(
      future: authController.isUserAlreadyLoggedIn(context),
      builder: (contect, authResult) {
        if (authResult.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (authResult.data == true) {
            return const Bottomnavigationbarr();
          }
          return LoginScreen();
        }
      },
    );
  }
}
