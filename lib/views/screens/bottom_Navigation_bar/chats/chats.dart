import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, String>> names = [
    {
      'image': "profile.jpg",
      'name': 'DJI Mavic Mini 2',
      'Product': 'Product Name',
    },

    {
      'image': "profile.jpg",
      'name': 'DJI Mavic Mini 2',
      'Product': 'Product Name',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.center,
          child: Text("Chats", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),

      body: ListView(
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

          ...names.map((singlename) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/chatconver");
                },
                child: Container(
                  height: 60,

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 159, 159, 159),
                    ),
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/${singlename["image"]}',
                              ),
                              radius: 20,
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              "${singlename['name']}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${singlename['Product']}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.pinkAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          // ...names.map((singlename) {
          //   return Padding(
          //     padding: const EdgeInsets.all(9.0),
          //     child: Container(
          //       // color: Colors.white,
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Color.fromARGB(255, 159, 159, 159)),
          //         shape: BoxShape.rectangle,
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(15),
          //       ),
          //       child: ListTile(
          //         contentPadding: EdgeInsets.all(8.0),
          //         title: Text(
          //           "${singlename['name']}",
          //           style: TextStyle(fontWeight: FontWeight.bold),
          //         ),
          //         subtitle: Text(
          //           "${singlename["Product"]}",
          //           style: TextStyle(
          //             color: Colors.pinkAccent,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         leading: CircleAvatar(
          //           backgroundImage: AssetImage(
          //             'assets/images/${singlename["image"]}',
          //           ),
          //           radius: 30,
          //         ),
          //       ),
          //     ),
          //   );
          // }),
        ],
      ),
    );
  }
}
