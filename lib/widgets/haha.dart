import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tech_assist_flutter_next/widgets/snackbar.dart';
import 'package:uuid/uuid.dart';

void showPayment(BuildContext context, String receover_id) {
  showModalBottomSheet(
      isScrollControlled: false,
      //   backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => SafeArea(
              child: PaymentCards(
            receiver_id: receover_id,
          )));
}

class PaymentCards extends StatefulWidget {
  const PaymentCards({Key? key, required String receiver_id})
      : _receiver_id = receiver_id;

  final String _receiver_id;

  @override
  _PaymentCardsState createState() => _PaymentCardsState();
}

class _PaymentCardsState extends State<PaymentCards> {
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

    final DocumentSnapshot rcvDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget._receiver_id)
        .get();

    setState(() {
      rcvName = rcvDoc.get('fullname');
      rcvPhone = rcvDoc.get('phoneNumber');
      senderName = userDoc.get('fullname');
      senderPhone = userDoc.get('phoneNumber');
    });
  }

  Future<void> onSendMessage(String contentMsg, int type) async {
    if (contentMsg != "") {
      User user = _auth.currentUser!;

      var docRef = FirebaseFirestore.instance
          .collection("messages")
          .doc(user.uid)
          .collection(user.uid)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      var receiveRef = FirebaseFirestore.instance
          .collection("messages")
          .doc(widget._receiver_id)
          .collection(widget._receiver_id)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      final senderData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final rcvData = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget._receiver_id)
          .get();
      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(docRef, {
          "idFrom": widget._receiver_id,
          "idTo": user.uid,
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          "content": contentMsg,
          "type": type,
          "senders_name": rcvData['fullname'],
          "senders_image": rcvData['imageurl'],
          "receiver_name": senderData['fullname'],

          "receiver_image": senderData['imageurl'],
          'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
              " " +
              DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
        });
      });

      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(receiveRef, {
          "idFrom": user.uid,
          "idTo": widget._receiver_id,
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          "content": contentMsg,
          "type": type,
          "senders_name": senderData['fullname'],
          "senders_image": senderData['imageurl'],
          "receiver_name": rcvData['fullname'],
          "receiver_image": rcvData['imageurl'],
          'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
              " " +
              DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return initialPage == 0
        ? Center(
            child: Container(
                //      decoration: BoxDecoration(
                // image: DecorationImage(
                //     image: NetworkImage(
                //         "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
                //     fit: BoxFit.cover)),
                height: 450,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bg2.png"),
                        fit: BoxFit.cover),
                    color: Color(0xfff9f2f2),
                    border: Border.all(
                      color: Color(0xffb6b3b3),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //  Spacer(),
                    Container(
                      padding: EdgeInsets.only(left: 8, bottom: 30),

                      child: Column(
                        //mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                          ),
                          Container(
                            height: 60,
                            width: 90,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xffb6b3b3),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Image.asset(
                              "assets/images/logo.png",
                              scale: 4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          Text(
                            "PAYMENT METHOD",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            color: Colors.white,
                            child: DropdownButton<String>(
                              elevation: 0,
                              hint: Text("Payment"),

                              // value: "Payment",
                              items: <String>[
                                //'Payment',
                                'GCASH',
                                //'DEBIT CARD',
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
                                });

                                print(value);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 110,
                          ),
                        ],
                      ),
                      // ),
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ],
                )),
          )
        : initialPage == 1
            ? Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bg2.png"),
                        fit: BoxFit.cover),
                    color: Color(0xfff9f2f2),
                    border: Border.all(
                      color: Color(0xffb6b3b3),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.only(left: 8, bottom: 30),
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 60,
                      width: 90,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xffb6b3b3),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Image.asset(
                        "assets/images/logo.png",
                        scale: 4,
                      ),
                    ),
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
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w700),
                        //controller: _controller,
                        autofocus: true,
                        cursorColor: Colors.greenAccent,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0))),
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
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w700),
                        //controller: _controller,
                        cursorColor: Colors.greenAccent,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0))),

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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                  style: GoogleFonts.roboto(
                                      letterSpacing: 2,
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    width: 1.0, color: Colors.grey[800]!),
                                shape: StadiumBorder(),
                                primary: Color(0xfff5970a),
                              )),
                        ),
                        SizedBox(width: 32),
                        Container(
                          width: 110,
                          height: 36,
                          child: ElevatedButton(
                              onPressed: () {
                                //if (paymentMethod == "GCASH") {
                                if (GcashNo.length < 11 || Amount == "") {
                                  //   showSnackBar(
                                  //       context,
                                  //       "Please input nessary fields",
                                  //       Colors.red,
                                  //       2000);

                                  Fluttertoast.showToast(
                                      msg: GcashNo.length < 11
                                          ? "Enter a GCash number with 11 digits please"
                                          : "Please input nessary fields",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      //webBgColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  setState(() {
                                    initialPage = 2;
                                  });
                                }

                                //}
                              },
                              child: Text("NEXT",
                                  style: GoogleFonts.roboto(
                                      letterSpacing: 2,
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    width: 1.0, color: Colors.grey[800]!),
                                shape: StadiumBorder(),
                                primary: Color(0xfff5970a),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : initialPage == 2
                ? Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/bg2.png"),
                            fit: BoxFit.cover),
                        color: Color(0xfff9f2f2),
                        border: Border.all(
                          color: Color(0xffb6b3b3),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.only(left: 8, bottom: 30),
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 60,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xffb6b3b3),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Image.asset(
                            "assets/images/logo.png",
                            scale: 4,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "From",
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
                              child: Text(senderName)),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "To",
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
                              child: Text(rcvName)),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "NOTE DESCRIPTION",
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
                          height: 60,
                          width: 165,
                          child: TextField(
                            maxLines: 3,
                            minLines: 3,
                            style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                fontWeight: FontWeight.w700),
                            //controller: _controller,
                            cursorColor: Colors.greenAccent,
                            decoration: InputDecoration(
                                hintText: "OPTIONAL",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0))),
                            onChanged: (value) {
                              setState(() {
                                description = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 110,
                              height: 36,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      initialPage = 1;
                                    });
                                  },
                                  child: Text("BACK",
                                      style: GoogleFonts.roboto(
                                          letterSpacing: 2,
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700)),
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        width: 1.0, color: Colors.grey[800]!),
                                    shape: StadiumBorder(),
                                    primary: Color(0xfff5970a),
                                  )),
                            ),
                            SizedBox(width: 32),
                            Container(
                              width: 110,
                              height: 36,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      //GCASH FIREBASE
                                      initialPage = 3;
                                    });
                                    var message =
                                        "Received: You have received PHP " +
                                            Amount +
                                            " of " +
                                            paymentMethod +
                                            " from " +
                                            senderName +
                                            " " +
                                            GcashNo +
                                            " on " +
                                            DateTime.now().toString() +
                                            " with message: " +
                                            description;
                                    final paymentId = uuid.v4();
                                    print(message);
                                    await FirebaseFirestore.instance
                                        .collection('payment')
                                        .doc(paymentId)
                                        .set({
                                      'id': paymentId,
                                      'date': DateTime.now().toString(),
                                      'paymentMethod': paymentMethod,
                                      'phone': GcashNo,
                                      'from': senderName,
                                      'to': rcvName,
                                      'amount': Amount,
                                      'message': message,
                                      'payment_status': 'PROCESS'
                                    });

                                    var message2 = 'Hey ' +
                                        senderName +
                                        ' we received your payment for your service worker.';

                                    var message3 = rcvName +
                                        ' we will give you your salary after you finish your contract. We will deduct 8% of your salary and it will go to the TechAssist';

                                    onSendMessage(message2, 2);
                                    print(message2);
                                    onSendMessage(message3, 2);
                                    print(message3);
                                  },
                                  child: Text("NEXT",
                                      style: GoogleFonts.roboto(
                                          letterSpacing: 2,
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700)),
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        width: 1.0, color: Colors.grey[800]!),
                                    shape: StadiumBorder(),
                                    primary: Color(0xfff5970a),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : initialPage == 3
                    ? Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/bg2.png"),
                                fit: BoxFit.cover),
                            color: Color(0xfff9f2f2),
                            border: Border.all(
                              color: Color(0xffb6b3b3),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: EdgeInsets.only(left: 8, bottom: 30),
                        child: Column(
                          //mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 80,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Text(
                                "Your payment is in process. Please wait for the update of our Admin. We will send you the confirmation of your payment in your message conversation together with your service worker.",
                                overflow: TextOverflow.fade,
                                style: new TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'Roboto',
                                  color: new Color(0xFF212121),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              height: 150,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xffb6b3b3),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 130,
                                  height: 36,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        // setState(() {
                                        //   initialPage = 3;
                                        // });

                                        Navigator.pop(context);
                                      },
                                      child: Text("CONTINUE",
                                          style: GoogleFonts.roboto(
                                              letterSpacing: 2,
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700)),
                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide(
                                            width: 1.0,
                                            color: Colors.grey[800]!),
                                        shape: StadiumBorder(),
                                        primary: Color(0xfff5970a),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : initialPage == 4
                        ? Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/bg2.png"),
                                    fit: BoxFit.cover),
                                color: Color(0xfff9f2f2),
                                border: Border.all(
                                  color: Color(0xffb6b3b3),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            padding: EdgeInsets.only(left: 8, bottom: 30),
                            child: Column(
                              //mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  height: 60,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Color(0xffb6b3b3),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: Image.asset(
                                    "assets/images/logo.png",
                                    scale: 4,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Your Paymaya Number",
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
                                        fontWeight: FontWeight.w700),
                                    //controller: _controller,
                                    autofocus: true,
                                    cursorColor: Colors.greenAccent,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0))),
                                    onChanged: (value) {
                                      setState(() {
                                        PaymayaNo = value;
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
                                        fontWeight: FontWeight.w700),
                                    //controller: _controller,
                                    cursorColor: Colors.greenAccent,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0))),

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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                              style: GoogleFonts.roboto(
                                                  letterSpacing: 2,
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700)),
                                          style: ElevatedButton.styleFrom(
                                            side: BorderSide(
                                                width: 1.0,
                                                color: Colors.grey[800]!),
                                            shape: StadiumBorder(),
                                            primary: Color(0xfff5970a),
                                          )),
                                    ),
                                    SizedBox(width: 32),
                                    Container(
                                      width: 110,
                                      height: 36,
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            if (PaymayaNo.length < 11 ||
                                                Amount == "") {
                                              Fluttertoast.showToast(
                                                  msg: PaymayaNo.length < 11
                                                      ? "Enter a Paymaya number with 11 digits please"
                                                      : "Please input nessary fields",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.TOP,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  //webBgColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              setState(() {
                                                initialPage = 5;
                                              });
                                              //   final paymentId = uuid.v4();
                                              //   await FirebaseFirestore.instance
                                              //       .collection('payment')
                                              //       .doc(paymentId)
                                              //       .set({
                                              //     'id': paymentId,
                                              //     'date':
                                              //         DateTime.now().toString(),
                                              //     'paymentMethod': paymentMethod,
                                              //     'phone': PaymayaNo,
                                              //     'from': senderName,
                                              //     'to': rcvName,
                                              //     'amount': Amount,
                                              //     'message': '',
                                              //     'payment_status': 'PROCESS'
                                              //   });

                                              //   var message2 = 'Hey ' +
                                              //       senderName +
                                              //       ' we received your payment for your service worker. Please type/TechAssist Okay if the contract is done.';

                                              //   var message3 = rcvName +
                                              //       ' we will give you your salary after you finish your contract. We will deduct 8% of your salary and it will go to the TechAssist';

                                              //   onSendMessage(message2, 2);
                                              //   print(message2);
                                              //   onSendMessage(message3, 2);
                                              //   print(message3);
                                            }
                                            //if (paymentMethod == "GCASH") {

                                            //}
                                          },
                                          child: Text("NEXT",
                                              style: GoogleFonts.roboto(
                                                  letterSpacing: 2,
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700)),
                                          style: ElevatedButton.styleFrom(
                                            side: BorderSide(
                                                width: 1.0,
                                                color: Colors.grey[800]!),
                                            shape: StadiumBorder(),
                                            primary: Color(0xfff5970a),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : initialPage == 5
                            ? Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage("assets/images/bg2.png"),
                                        fit: BoxFit.cover),
                                    color: Color(0xfff9f2f2),
                                    border: Border.all(
                                      color: Color(0xffb6b3b3),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                padding: EdgeInsets.only(left: 8, bottom: 30),
                                child: Column(
                                  //mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      height: 60,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Color(0xffb6b3b3),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: Image.asset(
                                        "assets/images/logo.png",
                                        scale: 4,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "From",
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
                                          child: Text(senderName)),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "To",
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
                                          child: Text(rcvName)),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "NOTE DESCRIPTION",
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
                                      height: 60,
                                      width: 165,
                                      child: TextField(
                                        maxLines: 3,
                                        minLines: 3,
                                        style: TextStyle(
                                            fontSize: 14,
                                            height: 1.5,
                                            fontWeight: FontWeight.w700),
                                        //controller: _controller,
                                        cursorColor: Colors.greenAccent,
                                        decoration: InputDecoration(
                                            hintText: "OPTIONAL",
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 15),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0))),
                                        onChanged: (value) {
                                          setState(() {
                                            description = value;
                                          });
                                        },
                                      ),
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
                                                setState(() {
                                                  initialPage = 4;
                                                });
                                              },
                                              child: Text("BACK",
                                                  style: GoogleFonts.roboto(
                                                      letterSpacing: 2,
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              style: ElevatedButton.styleFrom(
                                                side: BorderSide(
                                                    width: 1.0,
                                                    color: Colors.grey[800]!),
                                                shape: StadiumBorder(),
                                                primary: Color(0xfff5970a),
                                              )),
                                        ),
                                        SizedBox(width: 32),
                                        Container(
                                          width: 110,
                                          height: 36,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  //GCASH FIREBASE
                                                  initialPage = 6;
                                                });
                                                var message =
                                                    "Received: You have received PHP " +
                                                        Amount +
                                                        " of " +
                                                        paymentMethod +
                                                        " from " +
                                                        senderName +
                                                        " " +
                                                        PaymayaNo +
                                                        " on " +
                                                        DateTime.now()
                                                            .toString() +
                                                        " with message: " +
                                                        description;
                                                final paymentId = uuid.v4();
                                                print(message);
                                                await FirebaseFirestore.instance
                                                    .collection('payment')
                                                    .doc(paymentId)
                                                    .set({
                                                  'id': paymentId,
                                                  'date':
                                                      DateTime.now().toString(),
                                                  'paymentMethod':
                                                      paymentMethod,
                                                  'phone': PaymayaNo,
                                                  'from': senderName,
                                                  'to': rcvName,
                                                  'amount': Amount,
                                                  'message': message,
                                                  'payment_status': 'PROCESS'
                                                });

                                                var message2 = 'Hey ' +
                                                    senderName +
                                                    ' we received your payment for your service worker. Please type/TechAssist Okay if the contract is done.';

                                                var message3 = rcvName +
                                                    ' we will give you your salary after you finish your contract. We will deduct 8% of your salary and it will go to the TechAssist';

                                                onSendMessage(message2, 2);
                                                print(message2);
                                                onSendMessage(message3, 2);
                                                print(message3);
                                              },
                                              child: Text("NEXT",
                                                  style: GoogleFonts.roboto(
                                                      letterSpacing: 2,
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              style: ElevatedButton.styleFrom(
                                                side: BorderSide(
                                                    width: 1.0,
                                                    color: Colors.grey[800]!),
                                                shape: StadiumBorder(),
                                                primary: Color(0xfff5970a),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : initialPage == 6
                                ? Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/bg2.png"),
                                            fit: BoxFit.cover),
                                        color: Color(0xfff9f2f2),
                                        border: Border.all(
                                          color: Color(0xffb6b3b3),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    height: 450,
                                    width: double.infinity,
                                    // decoration: BoxDecoration(
                                    //     color: Color(0xfff9f2f2),
                                    //     border: Border.all(
                                    //       color: Color(0xffb6b3b3),
                                    //     ),
                                    //     borderRadius: BorderRadius.all(
                                    //         Radius.circular(10))),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 8, bottom: 30),
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                //mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 86,
                                                      ),
                                                      Icon(
                                                        Icons.check_circle,
                                                        color:
                                                            Colors.green[400],
                                                      ),
                                                      Text(
                                                        "Send Money Successfully!",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "Money Transfer Recipients",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                    color: Colors.grey[700],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "RECIPIENTS:",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[800],
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        "            " +
                                                            TechAssistNo,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "ACCOUNT TYPE:",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[800],
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        "            PAYMAYA",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "AMOUNT:",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[800],
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        "            PHP " +
                                                            Amount,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //   Text(
                                                      //     "MESSAGE:",
                                                      //     style: TextStyle(
                                                      //         color: Colors.grey[800],
                                                      //         fontSize: 12.0,
                                                      //         fontWeight:
                                                      //             FontWeight.w500),
                                                      //   ),
                                                      //   Text(
                                                      //     "            MESSAGE OF CLIENT",
                                                      //     style: TextStyle(
                                                      //         color: Colors.black,
                                                      //         fontSize: 14.0,
                                                      //         fontWeight:
                                                      //             FontWeight.w700),
                                                      //   ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      //   Container(
                                                      //     width: 110,
                                                      //     height: 36,
                                                      //     child: ElevatedButton(
                                                      //         onPressed: () {
                                                      //           //   Navigator.push(
                                                      //           //     context,
                                                      //           //     MaterialPageRoute(
                                                      //           //         builder: (context) => BottomBarScreen()),
                                                      //           //   );
                                                      //         },
                                                      //         child: Text("BACK",
                                                      //             style: GoogleFonts.roboto(
                                                      //                 letterSpacing:
                                                      //                     2,
                                                      //                 fontSize: 16,
                                                      //                 color: Colors
                                                      //                     .white,
                                                      //                 fontWeight:
                                                      //                     FontWeight
                                                      //                         .w700)),
                                                      //         style: ElevatedButton
                                                      //             .styleFrom(
                                                      //           side: BorderSide(
                                                      //               width: 1.0,
                                                      //               color: Colors
                                                      //                   .grey[800]!),
                                                      //           shape:
                                                      //               StadiumBorder(),
                                                      //           primary:
                                                      //               Color(0xfff5970a),
                                                      //         )),
                                                      //   ),
                                                      //   SizedBox(width: 32),
                                                      Container(
                                                        width: 110,
                                                        height: 36,
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                initialPage = 7;
                                                              });
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
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          )
                                        ],
                                      ),
                                    ))
                                : initialPage == 7
                                    ? Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/bg2.png"),
                                                fit: BoxFit.cover),
                                            color: Color(0xfff9f2f2),
                                            border: Border.all(
                                              color: Color(0xffb6b3b3),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        padding: EdgeInsets.only(
                                            left: 8, bottom: 30),
                                        child: Column(
                                          //mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 80,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 12),
                                              child: Text(
                                                "Your payment is in process. Please wait for the update of our Admin. We will send you the confirmation of your payment in your message conversation together with your service worker.",
                                                overflow: TextOverflow.fade,
                                                style: new TextStyle(
                                                  fontSize: 13.0,
                                                  fontFamily: 'Roboto',
                                                  color: new Color(0xFF212121),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              height: 150,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Color(0xffb6b3b3),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30))),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 130,
                                                  height: 36,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        // setState(() {
                                                        //   initialPage = 3;
                                                        // });

                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("CONTINUE",
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
                                    : Container();
  }
}
