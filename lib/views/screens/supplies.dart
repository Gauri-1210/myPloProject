import 'package:flutter/material.dart';

class Supplies extends StatefulWidget {
  const Supplies({super.key});
  @override
  _Supplies createState() => _Supplies();
}

class _Supplies extends State<Supplies> {
  final List<Map<String, dynamic>> items = [
    {
      "Name": "Baby Shower",
      "Time": "22 hours Ago",
      "Price": "\$899",
      "State": "Karnataka, India",
    },
    {
      "Name": "Baby Shower",
      "Time": "22 hours Ago",
      "Price": "\$899",
      "State": "Karnataka, India",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Part Supplies",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final item = items[index];

          return ListView(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  height: 150,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          image: DecorationImage(
                            image: AssetImage('assets/images/babyshower3.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),

                        // child:
                        //   Image.asset(
                        //     'assets/images/babyshower.jpg',
                        //     height: 110,
                        //     fit: BoxFit.fill,
                        //   ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Baby Shower",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$499",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "22 Hours Ago",
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          Text(
                            "Karnataka, India",
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.pinkAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
