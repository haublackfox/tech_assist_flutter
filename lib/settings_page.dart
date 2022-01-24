import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32, left: 32, right: 32),
      padding: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xffeae0e0),
          border: Border.all(
            color: Color(0xffeae0e0),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Text(
              "SETTINGS",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            onTap: () {},
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Text(
                      "My Account",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    child: Text(
                      "Notification Settings",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    child: Text(
                      "Support",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    child: Text(
                      "About",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () async {
                      // Navigator.canPop(context)? Navigator.pop(context):null;
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6.0),
                                    child: Image.network(
                                      'https://image.flaticon.com/icons/png/128/1828/1828304.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Sign out'),
                                  ),
                                ],
                              ),
                              content: const Text('Do you wanna Sign out?'),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () async {
                                      await _auth.signOut().then((value) =>
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          LoginPage())));
                                    },
                                    child: const Text(
                                      'Ok',
                                      style: TextStyle(color: Colors.red),
                                    ))
                              ],
                            );
                          });
                    },
                    child: Text(
                      "LOGOUT",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              )
            ],
          ),
          InkWell(
            child: Text(
              "TechAssist GCASH Number: 0935-4408-750",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
            ),
            onTap: () {},
          ),
          SizedBox(
            height: 6,
          ),
          InkWell(
            child: Text(
              "PAYMAYA Account Number: 0935-4408-750",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
            ),
            onTap: () {},
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
