// import 'package:flutter/material.dart';
// import 'package:my_plo/views/screens/bottom_Navigation_bar/payment/payout.dart';
// import 'package:my_plo/views/widgets/back.dart';

// class Homesubclass extends StatefulWidget {
//   const Homesubclass({super.key});
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Homesubclass> {
//   void onback() {
//     Navigator.pop(context);
//   }

//   final List<Map<String, dynamic>> Items = [
//     {"Item": "Birthday"},
//     {"Item": "Farewell"},
//     {"Item": "Anniversary"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(leading: Back.buildBack(onback)),
//       body: GestureDetector(
//         onTap: () {
//           Navigator.pushNamed(context, "/partyfurther");
//         },
//         child: GridView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: Items.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             childAspectRatio: 0.7,
//           ),
//           itemBuilder: (context, index) {
//             final item = Items[index];
//             return Column(
//               children: [
//                 Container(
//                   height: 120,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     gradient: LinearGradient(
//                       colors: [Colors.blue, Colors.pink],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.asset(
//                       'assets/images/my plo 1.png',
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Text("${item["Item"]}"),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
