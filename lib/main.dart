import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:my_plo/controller/auth/addproduct/addproduct_controller.dart';
import 'package:my_plo/controller/auth/auth.dart';

import 'package:my_plo/controller/controller.dart';
import 'package:my_plo/controller/home/home_controller.dart';
import 'package:my_plo/controller/payment/payment_controller.dart';
import 'package:my_plo/controller/payment/stripe_controller.dart';
import 'package:my_plo/controller/profile/profile_controller.dart';
import 'package:my_plo/views/screens/auth/forgot/forgot_screen.dart';
import 'package:my_plo/views/screens/auth/isalreadylogin/is_user_already_login.dart';
import 'package:my_plo/views/screens/auth/location/location_screen.dart';
import 'package:my_plo/views/screens/auth/login/login_screen.dart';
import 'package:my_plo/views/screens/auth/sign_up/signup_screen.dart';

import 'package:my_plo/views/screens/bottom_Navigation_bar/bottomNavigationBar.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/chats/actual_chats.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/chats/chats.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/home/home.dart';

import 'package:my_plo/views/screens/bottom_Navigation_bar/home/notifications.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/home/partyFurthersub.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/home/party_subclass.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/home/vendorFurthersub.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/home/vendor_subclass.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/profile/edit_profile.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/webview/web_view.dart';

import 'package:my_plo/views/screens/payment_method.dart';

import 'package:my_plo/views/screens/shipping&payment.dart';
import 'package:my_plo/views/screens/shipping.dart';

import 'package:my_plo/views/screens/slider.dart';
import 'package:my_plo/views/screens/splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_plo/views/screens/supplies.dart';
import 'package:provider/provider.dart';

import 'routes/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_txDJRlXoAFelCWzOrBdENCRS";

  await Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => AddproductController()),
        ChangeNotifierProvider(create: (_) => PaymentController()),
        ChangeNotifierProvider(create: (_) => StripeController()),
      ],
      child: MaterialApp(
        home: Splash(),

        navigatorKey: NavigationService.instance.navigationKey,
        theme: ThemeData(
          textTheme: GoogleFonts.archivoTextTheme(),

          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: Colors.white),
        ),

        routes: {
          '/loginscreen': (context) => LoginScreen(),
          "/signUpscreen": (context) => SignupScreen(),
          "/locationscreen": (context) => LocationScreen(),
          "/forgotscreen": (context) => ForgotScreen(),
          "/chatlist": (context) => Chats(),
          "/chatconver": (context) => ActualChats(),
          "/editProfile": (context) => EditProfile(),
          "/bottomnavigation": (context) => Bottomnavigationbarr(),
          "/home": (context) => Home(),
          "/notifications": (context) => Notifications(),
          "/webview": (context) => WebViewScreen(),

          "/shipping_payment": (context) => Shipping_payment(),
          // "/paymentMethod": (context) => PaymentMethod(),
          "/shipping": (context) => Shipping(),
          // "/homesub": (context) => Homesubclass(),
          "/vendorsub": (context) => VendorSubclass(),
          "/partyfurther": (context) => Partyfurthersub(),
          "/vendorfurther": (context) => Vendorfurthersub(),
          "/sliderView": (context) => SliderView(),
          "/userloginornot": (context) => IsUserLoggedInOrNot(),
        },
      ),
    );
  }
}
