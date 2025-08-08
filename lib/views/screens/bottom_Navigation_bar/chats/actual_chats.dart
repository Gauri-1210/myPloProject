import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_plo/theme/imagetheme/images.dart';

class ActualChats extends StatefulWidget {
  const ActualChats({super.key});
  @override
  _ActualState createState() => _ActualState();
}

class _ActualState extends State<ActualChats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color.fromARGB(255, 159, 159, 159)),
              ),
              child: IconButton(
                iconSize: 20,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_rounded),
              ),
            ),
          ],
        ),
        toolbarHeight: 70,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: ListTile(
              contentPadding: EdgeInsets.all(8.0),
              title: Text(
                "DJI Mavic Mini 2",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Product Name",
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage(Images.finalProfile),
                radius: 30,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 1,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 159, 159, 159),
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.topLeft,

                    child: Container(
                      height: 80,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Lorem ipsum dolor sit amet. Sed minima quia et numquam",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 80,
                            width: 216,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              color: Colors.purple,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Lorem ipsum dolor sit amet. Sed minima quia et numquam",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "12:35",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color.fromARGB(255, 223, 223, 223),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text("Write Your Message"),
                        ),
                        suffixIcon: CircleAvatar(
                          backgroundColor: Colors.pink,
                          child: Icon(Icons.send_rounded, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
