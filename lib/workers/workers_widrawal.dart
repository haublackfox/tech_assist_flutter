import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist_flutter_next/home_screen.dart';
import 'package:tech_assist_flutter_next/widgets/posts_cards.dart';
import 'package:uuid/uuid.dart';

class WorkersWidrawal extends StatefulWidget {
  const WorkersWidrawal({Key? key}) : super(key: key);

  @override
  _WorkersWidrawalState createState() => _WorkersWidrawalState();
}

class _WorkersWidrawalState extends State<WorkersWidrawal> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int initialPage = 0;
  String paymentMethod = '';

  String TechAssistNo = '09354408750';
  //GCASH
  String GcashNo = '';
  String PaymayaNo = '';
  String Amount = '';
  String from = '';
  String to = '';
  String description = '';

  String senderName = '';
  String rcvName = '';
  String rcvPhone = '';
  String senderPhone = '';
  var uuid = const Uuid();

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    User user = _auth.currentUser!;

    //user.isAnonymous ? null :
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    setState(() {
      senderName = userDoc.get('fullname');
      senderPhone = userDoc.get('phoneNumber');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('TechAssist',
              style: GoogleFonts.tinos(
                  textStyle: TextStyle(
                      letterSpacing: 1.3,
                      fontSize: 20,
                      //color: Color(0xff41a58d),
                      fontWeight: FontWeight.w500))),
          SizedBox(
            height: 8,
          ),
          Text('At TechAssist you will find a',
              style: GoogleFonts.tinos(
                  textStyle: TextStyle(
                      letterSpacing: 1.3,
                      fontSize: 20,
                      //color: Color(0xff41a58d),
                      fontWeight: FontWeight.w500))),
          SizedBox(
            height: 8,
          ),
          Text('Service Worker who is good and',
              style: GoogleFonts.tinos(
                  textStyle: TextStyle(
                      letterSpacing: 1.3,
                      fontSize: 20,
                      //color: Color(0xff41a58d),
                      fontWeight: FontWeight.w500))),
          SizedBox(
            height: 8,
          ),
          Text('quality when it comes to service.',
              style: GoogleFonts.tinos(
                  textStyle: TextStyle(
                      letterSpacing: 1.3,
                      fontSize: 20,
                      //color: Color(0xff41a58d),
                      fontWeight: FontWeight.w500))),
          Container(
            height: 400,
            //   constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 130,
                    image: AssetImage("assets/images/bg5.png"),
                    fit: BoxFit.cover)),
            width: double.infinity,
            child: Container(
              color: Colors.grey.withAlpha(90),
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text('REQUEST WITHDRAWAL',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 24,
                              //color: Color(0xff41a58d),
                              fontWeight: FontWeight.w700))),
                  //  initialPage == 0
                  //?
                  Center(
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 8, bottom: 30),
                            child: initialPage == 0
                                ? Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                      ),
                                      Text(
                                        "WITHDRAWAL METHOD",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        color: Colors.white,
                                        child: DropdownButton<String>(
                                          elevation: 0,
                                          hint: Text("Payment"),

                                          // value: "Payment",
                                          items: <String>[
                                            //'Payment',
                                            'GCASH',
                                            'PAYMAYA'
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              paymentMethod = value.toString();
                                            });
                                            if (paymentMethod == "GCASH") {
                                              setState(() {
                                                initialPage = 1;
                                              });
                                            }
                                            if (paymentMethod == "PAYMAYA") {
                                              setState(() {
                                                initialPage = 4;
                                              });
                                            }

                                            print(value);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 110,
                                      ),
                                    ],
                                  )
                                : initialPage == 1
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            left: 8, bottom: 30),
                                        child: Column(
                                          //mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "Your GCash Number",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Container(
                                              color: Colors.white,
                                              height: 30,
                                              width: 165,
                                              child: TextField(
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    height: 1.5,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                //controller: _controller,
                                                autofocus: true,
                                                cursorColor: Colors.greenAccent,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0,
                                                            horizontal: 15),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0))),
                                                onChanged: (value) {
                                                  setState(() {
                                                    GcashNo = value;
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "TechAssist GCash Number",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Center(
                                              child: Container(
                                                  color: Colors.white,
                                                  //   height: 30,
                                                  //   width: 165,
                                                  child: Text(TechAssistNo)),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "Amount",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Container(
                                              color: Colors.white,
                                              height: 30,
                                              width: 165,
                                              child: TextField(
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    height: 1.5,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                //controller: _controller,
                                                cursorColor: Colors.greenAccent,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0,
                                                            horizontal: 15),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0))),

                                                onChanged: (value) {
                                                  setState(() {
                                                    Amount = value;
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 110,
                                                  height: 36,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        //if (paymentMethod == "GCASH") {
                                                        setState(() {
                                                          initialPage = 0;
                                                        });
                                                        //}
                                                      },
                                                      child: Text("BACK",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  letterSpacing:
                                                                      2,
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        side: BorderSide(
                                                            width: 1.0,
                                                            color: Colors
                                                                .grey[800]!),
                                                        shape: StadiumBorder(),
                                                        primary:
                                                            Color(0xfff5970a),
                                                      )),
                                                ),
                                                SizedBox(width: 32),
                                                Container(
                                                  width: 110,
                                                  height: 36,
                                                  child: ElevatedButton(
                                                      onPressed: () async {
                                                        if (GcashNo.length <
                                                                11 ||
                                                            Amount == "") {
                                                          Fluttertoast
                                                              .showToast(
                                                                  msg: GcashNo.length < 11
                                                                      ? "Enter a Gcash number with 11 digits please"
                                                                      : "Please input nessary fields",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .TOP,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  //webBgColor: Colors.red,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0);
                                                        } else {
                                                          setState(() {
                                                            initialPage = 2;
                                                          });
                                                          final withdrawalId =
                                                              uuid.v4();

                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'withdrawal')
                                                              .doc(withdrawalId)
                                                              .set({
                                                            'id': withdrawalId,
                                                            'date':
                                                                DateTime.now()
                                                                    .toString(),
                                                            'paymentMethod':
                                                                paymentMethod,
                                                            'phone': GcashNo,
                                                            'withdrawer':
                                                                senderName,
                                                            'amount': Amount,
                                                            'withdraw_status':
                                                                'PENDING'
                                                          });
                                                        }
                                                        //if (paymentMethod == "GCASH") {

                                                        //}
                                                      },
                                                      child: Text("NEXT",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  letterSpacing:
                                                                      2,
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        side: BorderSide(
                                                            width: 1.0,
                                                            color: Colors
                                                                .grey[800]!),
                                                        shape: StadiumBorder(),
                                                        primary:
                                                            Color(0xfff5970a),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : initialPage == 2
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                left: 8, bottom: 30),
                                            child: Column(
                                              //mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 12),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "✔ 8% of the salary from the contract will be deducted and will go to TechAssist.",
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: new TextStyle(
                                                          fontSize: 13.0,
                                                          fontFamily: 'Roboto',
                                                          color: new Color(
                                                              0xFF212121),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      Text(
                                                        "✔ You will only receive your salary when you have completed your contract.",
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: new TextStyle(
                                                          fontSize: 13.0,
                                                          fontFamily: 'Roboto',
                                                          color: new Color(
                                                              0xFF212121),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      Container(
                                                        width: 130,
                                                        // height: 36,
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                initialPage = 3;
                                                              });

                                                              //   Navigator.pop(
                                                              //       context);
                                                            },
                                                            child: Text("OKAY",
                                                                style: GoogleFonts.roboto(
                                                                    letterSpacing:
                                                                        2,
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700)),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              side: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                          .grey[
                                                                      800]!),
                                                              shape:
                                                                  StadiumBorder(),
                                                              primary: Color(
                                                                  0xfff5970a),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  height: 200,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color:
                                                            Color(0xffb6b3b3),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30))),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // Container(
                                                    //   width: 130,
                                                    //   height: 36,
                                                    //   child: ElevatedButton(
                                                    //       onPressed: () {
                                                    //         // setState(() {
                                                    //         //   initialPage = 3;
                                                    //         // });

                                                    //         Navigator.pop(
                                                    //             context);
                                                    //       },
                                                    //       child: Text(
                                                    //           "CONTINUE",
                                                    //           style: GoogleFonts.roboto(
                                                    //               letterSpacing:
                                                    //                   2,
                                                    //               fontSize: 16,
                                                    //               color: Colors
                                                    //                   .white,
                                                    //               fontWeight:
                                                    //                   FontWeight
                                                    //                       .w700)),
                                                    //       style: ElevatedButton
                                                    //           .styleFrom(
                                                    //         side: BorderSide(
                                                    //             width: 1.0,
                                                    //             color:
                                                    //                 Colors.grey[
                                                    //                     800]!),
                                                    //         shape:
                                                    //             StadiumBorder(),
                                                    //         primary: Color(
                                                    //             0xfff5970a),
                                                    //       )),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : initialPage == 3
                                            ? Container(
                                                padding: EdgeInsets.only(
                                                    left: 8, bottom: 30),
                                                child: Column(
                                                  //mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 12),
                                                      child: Text(
                                                        "Your payment is in process. Please wait for the update of our Admin. We will send you the confirmation of your payment in your message conversation together with your service worker.",
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: new TextStyle(
                                                          fontSize: 13.0,
                                                          fontFamily: 'Roboto',
                                                          color: new Color(
                                                              0xFF212121),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      height: 150,
                                                      width: 300,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                            color: Color(
                                                                0xffb6b3b3),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 130,
                                                          height: 36,
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                // setState(() {
                                                                //   initialPage = 3;
                                                                // });
// Navigator.push(context, route)

                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              HomeScreen()),
                                                                );
                                                              },
                                                              child: Text(
                                                                  "CONTINUE",
                                                                  style: GoogleFonts.roboto(
                                                                      letterSpacing:
                                                                          2,
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                side: BorderSide(
                                                                    width: 1.0,
                                                                    color: Colors
                                                                            .grey[
                                                                        800]!),
                                                                shape:
                                                                    StadiumBorder(),
                                                                primary: Color(
                                                                    0xfff5970a),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : initialPage == 4
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        left: 8, bottom: 30),
                                                    child: Column(
                                                      //mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          "Your Paymaya Number",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          color: Colors.white,
                                                          height: 30,
                                                          width: 165,
                                                          child: TextField(
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                height: 1.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                            //controller: _controller,
                                                            autofocus: true,
                                                            cursorColor: Colors
                                                                .greenAccent,
                                                            decoration: InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        vertical:
                                                                            0,
                                                                        horizontal:
                                                                            15),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0))),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                PaymayaNo =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 12,
                                                        ),
                                                        Text(
                                                          "TechAssist Paymaya Number",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Center(
                                                          child: Container(
                                                              color:
                                                                  Colors.white,
                                                              //   height: 30,
                                                              //   width: 165,
                                                              child: Text(
                                                                  TechAssistNo)),
                                                        ),
                                                        SizedBox(
                                                          height: 12,
                                                        ),
                                                        Text(
                                                          "Amount",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          color: Colors.white,
                                                          height: 30,
                                                          width: 165,
                                                          child: TextField(
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                height: 1.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                            //controller: _controller,
                                                            cursorColor: Colors
                                                                .greenAccent,
                                                            decoration: InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        vertical:
                                                                            0,
                                                                        horizontal:
                                                                            15),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0))),

                                                            onChanged: (value) {
                                                              setState(() {
                                                                Amount = value;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: 110,
                                                              height: 36,
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        //if (paymentMethod == "GCASH") {
                                                                        setState(
                                                                            () {
                                                                          initialPage =
                                                                              0;
                                                                        });
                                                                        //}
                                                                      },
                                                                      child: Text(
                                                                          "BACK",
                                                                          style: GoogleFonts.roboto(
                                                                              letterSpacing: 2,
                                                                              fontSize: 16,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w700)),
                                                                      style: ElevatedButton.styleFrom(
                                                                        side: BorderSide(
                                                                            width:
                                                                                1.0,
                                                                            color:
                                                                                Colors.grey[800]!),
                                                                        shape:
                                                                            StadiumBorder(),
                                                                        primary:
                                                                            Color(0xfff5970a),
                                                                      )),
                                                            ),
                                                            SizedBox(width: 32),
                                                            Container(
                                                              width: 110,
                                                              height: 36,
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (PaymayaNo.length <
                                                                                11 ||
                                                                            Amount ==
                                                                                "") {
                                                                          //   showSnackBar(
                                                                          //       context,
                                                                          //       "Please input nessary fields",
                                                                          //       Colors.red,
                                                                          //       2000);

                                                                          Fluttertoast.showToast(
                                                                              msg: PaymayaNo.length < 11 ? "Enter a Paymaya number with 11 digits please" : "Please input nessary fields",
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              gravity: ToastGravity.TOP,
                                                                              timeInSecForIosWeb: 1,
                                                                              backgroundColor: Colors.red,
                                                                              //webBgColor: Colors.red,
                                                                              textColor: Colors.white,
                                                                              fontSize: 16.0);
                                                                        } else {
                                                                          setState(
                                                                              () {
                                                                            initialPage =
                                                                                2;
                                                                          });
                                                                          final withdrawalId =
                                                                              uuid.v4();

                                                                          await FirebaseFirestore
                                                                              .instance
                                                                              .collection('withdrawal')
                                                                              .doc(withdrawalId)
                                                                              .set({
                                                                            'id':
                                                                                withdrawalId,
                                                                            'date':
                                                                                DateTime.now().toString(),
                                                                            'paymentMethod':
                                                                                paymentMethod,
                                                                            'phone':
                                                                                PaymayaNo,
                                                                            'withdrawer':
                                                                                senderName,
                                                                            'amount':
                                                                                Amount,
                                                                            'withdraw_status':
                                                                                'PENDING'
                                                                          });
                                                                        }
                                                                        //if (paymentMethod == "GCASH") {

                                                                        //}
                                                                      },
                                                                      child: Text(
                                                                          "NEXT",
                                                                          style: GoogleFonts.roboto(
                                                                              letterSpacing: 2,
                                                                              fontSize: 16,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w700)),
                                                                      style: ElevatedButton.styleFrom(
                                                                        side: BorderSide(
                                                                            width:
                                                                                1.0,
                                                                            color:
                                                                                Colors.grey[800]!),
                                                                        shape:
                                                                            StadiumBorder(),
                                                                        primary:
                                                                            Color(0xfff5970a),
                                                                      )),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container()

                            // ),
                            ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    )),
                  )
                  // : Container()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
