// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:mainproject/student/assets/drawer.dart';

// class AllAssigned_TaskStud extends StatefulWidget {
//   const AllAssigned_TaskStud({super.key});

//   @override
//   State<AllAssigned_TaskStud> createState() => _AllAssigned_TaskStudState();
// }

// class _AllAssigned_TaskStudState extends State<AllAssigned_TaskStud> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 250,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage('images/register.png'), fit: BoxFit.cover),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           centerTitle: true,
//           // ignore: prefer_const_constructors
//           title: Text(
//             "Select Semester",
//             // ignore: prefer_const_constructors
//             style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontStyle: FontStyle.italic,
//                 fontFamily: 'RobotoMono'),
//           ),
//           actions: [
//             Container(
//                 margin: EdgeInsets.only(right: 10),
//                 child: IconButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, "/studaddnewpost");
//                     },
//                     // ignore: prefer_const_constructors
//                     icon: Icon(Icons.add_card_sharp))),
//             Container(
//                 margin: EdgeInsets.only(right: 10),
//                 child: IconButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, "/studmessage");
//                     },
//                     icon: Icon(Icons.message_sharp)))
//           ],
//         ),
//         body: ListView(children: [
//           Container(
//             margin: EdgeInsets.all(10),
//             child: Center(
//                 child: Column(
//               children: [
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Text(
//                   'Select The Semester',
//                   style: TextStyle(
//                     fontFamily: 'Roboto',
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     fontStyle: FontStyle.italic,
//                     color: Color.fromARGB(255, 228, 230, 233),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Card(
//                   child: InkWell(
//                     onTap: () => {
//                       Navigator.pushNamed(context, "/studdepaccdemytaskview",
//                           arguments: {'semester': "1"})
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Row(
//                         // ignore: prefer_const_literals_to_create_immutables
//                         children: [
//                           Icon(Icons.onetwothree_outlined),
//                           SizedBox(width: 16),
//                           Text("Semester 1"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   child: InkWell(
//                     onTap: () => {
//                       Navigator.pushNamed(context, "/studdepaccdemytaskview",
//                           arguments: {'semester': "2"})
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Row(
//                         // ignore: prefer_const_literals_to_create_immutables
//                         children: [
//                           Icon(Icons.onetwothree_outlined),
//                           SizedBox(width: 16),
//                           Text("Semester 2"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   child: InkWell(
//                     onTap: () => {
//                       Navigator.pushNamed(context, "/studdepaccdemytaskview",
//                           arguments: {'semester': "3"})
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Row(
//                         // ignore: prefer_const_literals_to_create_immutables
//                         children: [
//                           Icon(Icons.onetwothree_outlined),
//                           SizedBox(width: 16),
//                           Text("Semester 3"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   child: InkWell(
//                     onTap: () => {
//                       Navigator.pushNamed(context, "/studdepaccdemytaskview",
//                           arguments: {'semester': "4"})
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Row(
//                         // ignore: prefer_const_literals_to_create_immutables
//                         children: [
//                           Icon(Icons.onetwothree_outlined),
//                           SizedBox(width: 16),
//                           Text(
//                             "Semester 4",
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   child: InkWell(
//                     onTap: () => {
//                       Navigator.pushNamed(context, "/studdepaccdemytaskview",
//                           arguments: {'semester': "5"})
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Row(
//                         // ignore: prefer_const_literals_to_create_immutables
//                         children: [
//                           Icon(Icons.onetwothree_outlined),
//                           SizedBox(width: 16),
//                           Text("Semester 5"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   child: InkWell(
//                     onTap: () => {
//                       Navigator.pushNamed(context, "/studdepaccdemytaskview",
//                           arguments: {'semester': "6"})
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Row(
//                         // ignore: prefer_const_literals_to_create_immutables
//                         children: [
//                           Icon(Icons.onetwothree_outlined),
//                           SizedBox(width: 16),
//                           Text("Semester 6"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//           ),
//         ]),
//         drawer: studDrawer(),
//       ),
//     );
//   }
// }
