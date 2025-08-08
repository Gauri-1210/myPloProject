import 'package:flutter/material.dart';
import 'package:my_plo/core/constants/appconstants.dart';
import 'package:my_plo/views/widgets/back.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  void onback() {
    Navigator.pop(context);
  }

  final List<Map<String, String>> names = [
    {"message": "Order from joe cancelled.", "time": "08.26AM"},
    {"message": "New order from Noah.", "time": "08.28AM"},
    {"message": "Item returned by Jack.", "time": "08.36AM"},
    {"message": "Order Shipped.", "time": "08.36AM"},
    {"message": "Received a payment for Order ID XXXX.", "time": "08.38AM"},
    {"message": "Item returned by Jack.", "time": "08.38AM"},
    {"message": "Order Shipped", "time": "08.39AM"},
    {"message": "Received a payment for Order ID XXXX.", "time": "08.40AM"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        leading: Back.buildBack(onback),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.apphorizontal,
        ),
        child: ListView(
          children: [
            ...names.map((singlename) {
              return Card(
                child: ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.pink),
                  ),
                  title: Text(
                    "${singlename["message"]}",
                    style: TextStyle(fontSize: 13),
                  ),

                  // Image.asset('assets/images/imgnew.jpg'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${singlename["time"]}",
                        style: TextStyle(color: Colors.pink),
                      ),
                    ],
                  ),
                ),
              );
            }),
            // ListView.builder(
            //   itemCount: names.length,
            //   itemBuilder: (context, index) {
            //     return ListTile(title: Text("${names[index]["name"]}"));
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
