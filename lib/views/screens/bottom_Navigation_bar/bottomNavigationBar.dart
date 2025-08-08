import 'package:flutter/material.dart';
import 'package:my_plo/controller/auth/addproduct/addproduct_controller.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/chats/chats.dart'
    show Chats;
import 'package:my_plo/views/screens/bottom_Navigation_bar/home/home.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/payment/payout.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/products/products.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/profile/profile_view.dart';
import 'package:provider/provider.dart';

class Bottomnavigationbarr extends StatefulWidget {
  const Bottomnavigationbarr({super.key});
  @override
  _stateful createState() => _stateful();
}

class _stateful extends State<Bottomnavigationbarr> {
  String firstName = "Gauri";
  int _selectedIndex = 0;

  static final List _pages = [
    Home(),
    // Chats(),
    Products(),
    PayoutScreen(),
    ProfileView(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddproductController addproductController =
        Provider.of<AddproductController>(context, listen: false);
    Map requestData = {"type": "partySupply"};
    addproductController.getCategories(
      context: context,
      requestData: requestData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Color.fromARGB(255, 159, 159, 159),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.chat_bubble_outlined),
          //   label: "Chats",
          // ),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "SELL"),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment_rounded),
            label: "Payout",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
