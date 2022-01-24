import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_assist_flutter_next/screens/paypal/MakePayment.dart';
import 'package:tech_assist_flutter_next/workers/workers_home_page.dart';
import 'package:tech_assist_flutter_next/workers/workers_widrawal.dart';

import './home_page.dart';
import './message_screen.dart';
import './services_page.dart';
import './settings_page.dart';

import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid = '';
  String _id = '';
  String _name = '';
  String _email = '';
  String _joinedAt = '';
  String _userImageUrl = '';
  String _phoneNumber = '';
  String _jobDesc = '';
  String _jobExp = '';
  String _isClient = '';
  int initialPage = 0;
  List<Widget> pageList = [
    HomePage(),
    ServiceScreen(),
    //ServiceScreen(),
    MessageScreen(),
    SettingsPage()
  ];

  List<Widget> pageList2 = [
    // makePayment(),
    WorkersHomePage(),
    WorkersWidrawal(),
    //ServiceScreen(),
    MessageScreen(),
    SettingsPage()
  ];

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = _auth.currentUser!;
    _uid = user.uid;
    print("USERRRRRRRRRRRRRRR");
    print(user.uid);
    print("USERRRRRRRRRRRRRRR");

    // print('user.displayName ${user.displayName}');
    // print('user.photoURL ${user.photoURL}');
    //user.isAnonymous ? null :
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();

    print("HAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA $userDoc");
    _id = userDoc.get('id');
    print("HAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA $_id");

    // if (userDoc == null) {
    //   return;
    // } else {
    setState(() {
      _id = userDoc.get('id');
      _name = userDoc.get('fullname');
      _email = userDoc.get('email');
      _phoneNumber = userDoc.get('phoneNumber');
      _userImageUrl = userDoc.get('imageurl');
      _jobDesc = userDoc.get('jobdescription');
      _jobExp = userDoc.get('jobexperience');
      _isClient = userDoc.get('isClient').toString();

      prefs.setString('id', userDoc.get('id'));
      prefs.setString('fullname', _name);
      prefs.setString('email', _email);
      prefs.setString('phoneNumber', _phoneNumber);
      prefs.setString('userImageUrl', _userImageUrl);
      prefs.setString('jobDesc', _jobDesc);
      prefs.setString('jobExp', _jobExp);
    });

    print("HAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA $_id");

    print("HAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA $_isClient");

    // print()
    // Future<String> tryt = await prefs.getString("id");
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/bg4.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Container(
              width: double.infinity,

              // padding: EdgeInsets.symmetric(horizontal: 70),
              // child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                height: 800,
                color: Colors.white.withAlpha(200),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        color: Color(0xfff9f0f0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    initialPage = 0;
                                  });
                                },
                                child: Text(
                                  "HOME",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    decoration: initialPage == 0
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationThickness: 4,
                                  ),
                                )),
                            SizedBox(
                              width: 6,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    initialPage = 1;
                                  });
                                },
                                child: Text(
                                  _isClient == "false"
                                      ? "WITHDRAWAL"
                                      : "SERVICES",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    decoration: initialPage == 1
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationThickness: 4,
                                  ),
                                )),
                            SizedBox(
                              width: 6,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    initialPage = 2;
                                  });
                                },
                                child: Text(
                                  "MESSAGE",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    decoration: initialPage == 2
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationThickness: 4,
                                  ),
                                )),
                            SizedBox(
                              width: 6,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    initialPage = 3;
                                  });
                                },
                                child: Text(
                                  "SETTINGS",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    decoration: initialPage == 3
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationThickness: 4,
                                  ),
                                )),
                            SizedBox(
                              width: 6,
                            )
                          ],
                        ),
                      ),
                      _isClient == "false"
                          ? pageList2[initialPage]
                          : pageList[initialPage]
                      //  : pageList2[initialPage]
                    ]),
              ),
              // ),
            ),
          )
        ],
      )),
    );
  }
}
