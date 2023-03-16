// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';

import '../../assets/drawer.dart';

class Manage_Post extends StatefulWidget {
  const Manage_Post({super.key});

  @override
  State<Manage_Post> createState() => _Manage_PostState();
}

class _Manage_PostState extends State<Manage_Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          // ignore: prefer_const_constructors
          title: Text(
            "Time Line",
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontFamily: 'RobotoMono'),
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/admnaddpost");
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(Icons.add_card_sharp))),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/admnmessage");
                    },
                    icon: Icon(Icons.message_sharp)))
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('https://picsum.photos/250'),
                                  radius: 20,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text('John Doe',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('10 mins ago',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.more_horiz),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat velit ut leo sollicitudin, vel viverra augue porttitor. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('https://picsum.photos/250'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.delete),
                            label: Text('Remove'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        drawer: cldrawer(),
      ),
    );
  }
}
