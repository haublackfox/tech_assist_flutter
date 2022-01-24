// import 'package:bubble/bubble.dart';
// import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
// import 'package:speech_bubble/speech_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist_flutter_next/widgets/message_card.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      //color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Message Thread",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
          SizedBox(
            height: 16,
          ),
          OrderCard()
        ],
      ),
    );
  }
}
