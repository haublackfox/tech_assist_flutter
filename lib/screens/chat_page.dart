// import 'dart:io';
// import 'dart:ui';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tech_assist_flutter_next/widgets/haha.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage(
//       {Key? key, required this.receiverId, required this.receiverName})
//       : super(key: key);

//   final String receiverId;
//   final String receiverName;

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   final TextEditingController msgCtrl = TextEditingController();
//   final FocusNode focusNode = FocusNode();
//   final ScrollController listScrollCtrl = ScrollController();
//   File? selectedImage;
// //   final Reference storageRef = FirebaseStorage.instance.ref();
// //   String? _userName = '';
//   //late Future<String> _counter;
//   String imageUrl = '';

//   String chatId = "";
//   String userId = "";
//   var listMessage;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   @override
//   void initState() {
//     super.initState();
//     readLocal();
//   }

//   readLocal() async {
//     String userId = _auth.currentUser!.uid;

//     if (userId.hashCode <= widget.receiverId.hashCode) {
//       chatId = '$userId-$widget.receiverId';
//     } else {
//       chatId = '$widget.receiverId-$userId';
//     }
//     setState(() {});
//   }

//   Future<void> onSendMessage(String contentMsg, int type) async {
//     if (contentMsg != "") {
//       User user = _auth.currentUser!;

//       try {
//         // var groupRef =
//         //     FirebaseFirestore.instance.collection("group").doc(chatId);

//         // var docRef =
//         //     FirebaseFirestore.instance.collection("messages").doc(user.uid);

//         // print(object)

//         //   var receiveRef = FirebaseFirestore.instance
//         //       .collection("messages")
//         //       .doc(widget.receiverId)
//         //       .collection(widget.receiverId)
//         //       .doc(DateTime.now().millisecondsSinceEpoch.toString());

//         final senderData = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();

//         print("SENDER");
//         print(senderData);
//         print("SENDER");

//         final rcvData = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(widget.receiverId)
//             .get();

//         print("rcv");
//         print(rcvData);
//         print("rcv");

//         // FirebaseFirestore.instance.runTransaction((transaction) async {
//         //   await transaction.set(docRef, {
//         //     "idFrom": user.uid,
//         //     "idTo": widget.receiverId,
//         //     "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
//         //     "content": contentMsg,
//         //     "type": type,
//         //     "senders_name": senderData['fullname'],
//         //     "senders_image": senderData['imageurl'],
//         //     "receiver_name": rcvData['fullname'],
//         //     "receiver_image": rcvData['imageurl'],
//         //     'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
//         //         " " +
//         //         DateFormat("hh:mm:ss a")
//         //             .format(DateTime.now()), //DateTime.now(),
//         //   });
//         // });

//         // await FirebaseFirestore.instance.collection('group').doc(chatId).set({
//         //   "idFrom": user.uid,
//         //   "idTo": widget.receiverId,
//         //   "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
//         //   "content": contentMsg,
//         //   "type": type,
//         //   "senders_name": senderData['fullname'],
//         //   "senders_image": senderData['imageurl'],
//         //   "receiver_name": rcvData['fullname'],
//         //   "receiver_image": rcvData['imageurl'],
//         //   'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
//         //       " " +
//         //       DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
//         // });

//         // DocumentSnapshot doc = await FirebaseFirestore.instance
//         //     .collection('groups')
//         //     .doc(chatId)
//         //     .get();

//         // print("doc");
//         // print(doc);
//         // print("doc");
//         // if (!doc.exists) {
//         await FirebaseFirestore.instance.collection('groups').doc(chatId).set({
//           "idFrom": user.uid,
//           "idTo": widget.receiverId,
//           "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
//           "content": contentMsg,
//           "type": type,
//           "senders_name": senderData['fullname'],
//           "senders_image": senderData['imageurl'],
//           "receiver_name": rcvData['fullname'],
//           "receiver_image": rcvData['imageurl'],
//           'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
//               " " +
//               DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
//         });
//         // }

//         // FirebaseFirestore.instance.runTransaction((transaction) async {
//         //   await transaction.set(groupRef, {
//         //     "idFrom": user.uid,
//         //     "idTo": widget.receiverId,
//         //     "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
//         //     "content": contentMsg,
//         //     "type": type,
//         //     "senders_name": senderData['fullname'],
//         //     "senders_image": senderData['imageurl'],
//         //     "receiver_name": rcvData['fullname'],
//         //     "receiver_image": rcvData['imageurl'],
//         //     'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
//         //         " " +
//         //         DateFormat("hh:mm:ss a")
//         //             .format(DateTime.now()), //DateTime.now(),
//         //   });
//         // });
//       } catch (e) {
//         print(e);
//       }
//       //   FirebaseFirestore.instance.runTransaction((transaction) async {
//       //     await transaction.set(receiveRef, {
//       //       "idFrom": user.uid,
//       //       "idTo": widget.receiverId,
//       //       "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
//       //       "content": contentMsg,
//       //       "type": type,
//       //       "senders_name": senderData['fullname'],
//       //       "senders_image": senderData['imageurl'],
//       //       "receiver_name": rcvData['fullname'],
//       //       "receiver_image": rcvData['imageurl'],
//       //       'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
//       //           " " +
//       //           DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
//       //     });
//       //   });

//       //   FirebaseFirestore.instance.runTransaction((transaction) async {
//       //     await transaction.set(receiveRef, {
//       //       "idFrom": userId,
//       //       "idTo": widget.receiverId,
//       //       "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
//       //       "content": contentMsg,
//       //       "type": type,
//       //     });
//       //   });
//       listScrollCtrl.animateTo(0.0,
//           duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//     }
//   }

//   getImageFromGallery() async {
//     User user = _auth.currentUser!;
//     final pickedImage =
//         await ImagePicker().getImage(source: ImageSource.gallery);
//     selectedImage = File(pickedImage!.path);

//     if (selectedImage != null) {
//       EasyLoading.show(status: 'loading...');
//       final ref = FirebaseStorage.instance
//           .ref()
//           .child('shopImages')
//           .child(user.uid + DateTime.now().toString() + '.jpg');
//       await ref.putFile(selectedImage!);
//       String url = await ref.getDownloadURL();

//       //   var docRef = FirebaseFirestore.instance
//       //       .collection("messages")
//       //       .doc(user.uid)
//       //       .collection(user.uid)
//       //       .doc(DateTime.now().millisecondsSinceEpoch.toString());

//       //   var receiveRef = FirebaseFirestore.instance
//       //       .collection("messages")
//       //       .doc(widget.receiverId)
//       //       .collection(widget.receiverId)
//       //       .doc(DateTime.now().millisecondsSinceEpoch.toString());

//       //   final senderData = await FirebaseFirestore.instance
//       //       .collection('users')
//       //       .doc(user.uid)
//       //       .get();

//       //   final rcvData = await FirebaseFirestore.instance
//       //       .collection('users')
//       //       .doc(widget.receiverId)
//       //       .get();
//       //   FirebaseFirestore.instance.runTransaction((transaction) async {
//       //     await transaction.set(docRef, {
//       //       "idFrom": user.uid,
//       //       "idTo": widget.receiverId,
//       //       "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
//       //       "content": url,
//       //       "type": 1,
//       //       "senders_name": senderData['fullname'],
//       //       "senders_image": senderData['imageurl'],
//       //       "receiver_name": rcvData['fullname'],
//       //       "receiver_image": rcvData['imageurl'],
//       //       'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
//       //           " " +
//       //           DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
//       //     });
//       //   });

//       //   FirebaseFirestore.instance.runTransaction((transaction) async {
//       //     await transaction.set(receiveRef, {
//       //       "idFrom": user.uid,
//       //       "idTo": widget.receiverId,
//       //       "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
//       //       "content": url,
//       //       "type": 1,
//       //       "senders_name": senderData['fullname'],
//       //       "senders_image": senderData['imageurl'],
//       //       "receiver_name": rcvData['fullname'],
//       //       "receiver_image": rcvData['imageurl'],
//       //       'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
//       //           " " +
//       //           DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
//       //     });
//       //   });
//       EasyLoading.showSuccess('Great Success!');
//     }

//     setState(() {});
//   }

//   getImageFromCamera() async {
//     User user = _auth.currentUser!;
//     final pickedImage =
//         await ImagePicker().getImage(source: ImageSource.camera);
//     selectedImage = File(pickedImage!.path);

//     if (selectedImage != null) {
//       EasyLoading.show(status: 'loading...');
//       final ref = FirebaseStorage.instance
//           .ref()
//           .child('shopImages')
//           .child(user.uid + DateTime.now().toString() + '.jpg');
//       await ref.putFile(selectedImage!);
//       String url = await ref.getDownloadURL();

//       //   var docRef = FirebaseFirestore.instance
//       //       .collection("messages")
//       //       .doc(user.uid)
//       //       .collection(user.uid)
//       //       .doc(DateTime.now().millisecondsSinceEpoch.toString());

//       //   var receiveRef = FirebaseFirestore.instance
//       //       .collection("messages")
//       //       .doc(widget.receiverId)
//       //       .collection(widget.receiverId)
//       //       .doc(DateTime.now().millisecondsSinceEpoch.toString());

//       //   final senderData = await FirebaseFirestore.instance
//       //       .collection('users')
//       //       .doc(user.uid)
//       //       .get();

//       //   final rcvData = await FirebaseFirestore.instance
//       //       .collection('users')
//       //       .doc(widget.receiverId)
//       //       .get();
//       //   FirebaseFirestore.instance.runTransaction((transaction) async {
//       //     await transaction.set(docRef, {
//       //       "idFrom": user.uid,
//       //       "idTo": widget.receiverId,
//       //       "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
//       //       "content": url,
//       //       "type": "1",
//       //       "senders_name": senderData['fullname'],
//       //       "senders_image": senderData['imageurl'],
//       //       "receiver_name": rcvData['fullname'],
//       //       "receiver_image": rcvData['imageurl'],
//       //       'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
//       //           " " +
//       //           DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
//       //     });
//       //   });

//       //   FirebaseFirestore.instance.runTransaction((transaction) async {
//       //     await transaction.set(receiveRef, {
//       //       "idFrom": user.uid,
//       //       "idTo": widget.receiverId,
//       //       "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
//       //       "content": url,
//       //       "type": "1",
//       //       "senders_name": senderData['fullname'],
//       //       "senders_image": senderData['imageurl'],
//       //       "receiver_name": rcvData['fullname'],
//       //       "receiver_image": rcvData['imageurl'],
//       //       'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
//       //           " " +
//       //           DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
//       //     });
//       //   });

//       EasyLoading.showSuccess('Great Success!');
//     }

//     setState(() {});
//   }

//   selectImage(parentContext) {
//     return showDialog(
//       context: parentContext,
//       builder: (context) {
//         return SimpleDialog(
//           title: Text("Choose image by:"),
//           children: <Widget>[
//             SimpleDialogOption(
//                 child: Text(
//                   "Photo with Camera",
//                   style: TextStyle(color: Colors.blue),
//                 ),
//                 onPressed: () async {
//                   Navigator.pop(context);
//                   await getImageFromCamera();
//                   //   Navigator.pop(context);
//                 }),
//             SimpleDialogOption(
//                 child: Text("Image from Gallery",
//                     style: TextStyle(color: Colors.blue)),
//                 onPressed: () async {
//                   Navigator.pop(context);
//                   await getImageFromGallery();
//                   //   Navigator.pop(context);
//                 }),
//             SimpleDialogOption(
//               child: Text("Cancel", style: TextStyle(color: Colors.red)),
//               onPressed: () => Navigator.pop(context),
//             )
//           ],
//         );
//       },
//     );
//   }

//   Future uploadImageFile() async {
//     //    showSnackBar(context, "Saving image please wait...", Colors.blue, 5000);
//     // String postId =
//     //     widget.user.uid + "_" + timestamp.toString().split(' ').join();
//     // UploadTask uploadTask =
//     //     storageRef.child("post_$postId.jpg").putFile(widget.image);
//     // TaskSnapshot storageSnap = await uploadTask;
//     // String downloadUrl = await storageSnap.ref.getDownloadURL();
//     // createPostInFirestore(mediaUrl: downloadUrl);
//     //   String file

//     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     Reference storageRef =
//         FirebaseStorage.instance.ref().child("Chat Images").child(fileName);

//     UploadTask storageUploadTask = storageRef.putFile(selectedImage!);
//     TaskSnapshot storageTaskSnapshot = await storageUploadTask;

//     storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
//       imageUrl = downloadUrl;
//       setState(() {
//         onSendMessage(imageUrl, 1);
//       });
//     });
//     //.onError((error, stackTrace) => print(error));
//   }

//   Widget msgScreen() {
//     return Container(
//         height: 450,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             color: Color(0xfff9f2f2),
//             border: Border.all(
//               color: Color(0xffb6b3b3),
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(10))),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
//               decoration: BoxDecoration(
//                   color: Color(0xffd6d0d0),
//                   border: Border.all(
//                     color: Color(0xffb6b3b3),
//                   ),
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   //   Column(
//                   //     children: [
//                   //       Container(
//                   //         decoration: BoxDecoration(
//                   //             color: Colors.white, border: Border.all()),
//                   //         height: 80,
//                   //         child: Image.asset("assets/images/beta_profile.png"),
//                   //       ),
//                   //     ],
//                   //   ),
//                   SizedBox(
//                     width: 50,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(widget.receiverName,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w700,
//                           )),
//                       SizedBox(
//                         height: 4,
//                       ),
//                       Container(
//                         width: 300,
//                         child: Flexible(
//                           child: Text(
//                             'Thanks for sending me a message Just leave your inquiries/message I\'ll",',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),

//                         // Column(
//                         //     crossAxisAlignment: CrossAxisAlignment.start,
//                         //     children: [
//                         //       Text('Thanks for sending me a message "CLIENT',
//                         //           style: TextStyle(
//                         //             fontSize: 12,
//                         //             fontWeight: FontWeight.w700,
//                         //           )),
//                         //       Text(
//                         //           "NAME! Just leave your inquiries/message I'll",
//                         //           style: TextStyle(
//                         //             fontSize: 12,
//                         //             fontWeight: FontWeight.w700,
//                         //           )),
//                         //       Text('check it later!',
//                         //           style: TextStyle(
//                         //             fontSize: 12,
//                         //             fontWeight: FontWeight.w700,
//                         //           )),
//                         //     ]),
//                       ),
//                       SizedBox(
//                         height: 4,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Container(
//                 width: 240,
//                 child: Row(
//                   children: [
//                     Spacer(),
//                     Text('06/25/21  12:27am',
//                         style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w700,
//                             color: Color(0xff757575))),
//                   ],
//                 )),
//             SizedBox(
//               height: 8,
//             ),
//             Row(children: [
//               Spacer(),
//               Container(
//                 padding: EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                     color: Color(0xffffbe7d),
//                     border: Border.all(
//                       color: Color(0xffb6b3b3),
//                     ),
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text('Sent:',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               )),
//                           Text(' Hi sir Agsamosam, Electrician po',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               )),
//                         ],
//                       ),
//                       Text('kayo? Gusto ko po sana mag paayos ng',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                           )),
//                       Text('wiring ng kuryente dito sa Bahay!',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                           )),
//                     ]),
//               ),
//             ]),
//             SizedBox(
//               height: 8,
//             ),
//             Container(
//                 width: 240,
//                 child: Row(
//                   children: [
//                     Spacer(),
//                     Text('06/25/21  12:27am',
//                         style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w700,
//                             color: Color(0xff757575))),
//                   ],
//                 )),
//             SizedBox(
//               height: 8,
//             ),
//             Container(
//               padding: EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                   color: Color(0xff9dd4e5),
//                   border: Border.all(
//                     color: Color(0xffb6b3b3),
//                   ),
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Received: Ah Sir, Saan po ang location',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                         )),
//                     Text('niyo and pwede po makita yung aayusin',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                         )),
//                     Text('na wirings?',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                         )),
//                   ]),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Row(
//               children: [
//                 Spacer(),
//                 Container(
//                   padding: EdgeInsets.all(4),
//                   decoration: BoxDecoration(
//                       color: Color(0xffffbe7d),
//                       border: Border.all(
//                         color: Color(0xffb6b3b3),
//                       ),
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Received: Ah Sir, Saan po ang location',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                             )),
//                         Text('niyo and pwede po makita yung aayusin',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                             )),
//                         Text('na wirings?',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                             )),
//                       ]),
//                 ),
//               ],
//             ),
//             Spacer(),
//             Row(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     print("HAHAHAHAHAHAfafadsfaf");
//                     selectImage(context);
//                   }, //get
//                   child: Icon(
//                     FontAwesomeIcons.plus,
//                     size: 30,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     print("TAAAAAAAAAAAAAAAAAAAP");
//                     showPayment(context, widget.receiverId);
//                   },
//                   child: Icon(
//                     FontAwesomeIcons.moneyBillWaveAlt,
//                     size: 30,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Container(
//                   color: Color(0xffdfd1d1),
//                   height: 30,
//                   width: 270,
//                   child: TextField(
//                     style: TextStyle(
//                         fontSize: 14, height: 1.5, fontWeight: FontWeight.w700),
//                     //controller: _controller,
//                     cursorColor: Colors.greenAccent,
//                     decoration: InputDecoration(
//                         contentPadding:
//                             EdgeInsets.symmetric(vertical: 0, horizontal: 15),
//                         hintText: "Enter Message here",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(0))),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 3,
//                 ),
//                 Icon(
//                   Icons.send,
//                   size: 30,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 8,
//             )
//           ],
//         ));
//   }

//   Widget top() {
//     return Container(
//         //height: 450,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             color: Color(0xfff9f2f2),
//             border: Border.all(
//               color: Color(0xffb6b3b3),
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(10))),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           SizedBox(
//             height: 40,
//           ),
//           Text(
//             "MESSAGE",
//             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//           ),
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
//             decoration: BoxDecoration(
//                 color: Color(0xffd6d0d0),
//                 border: Border.all(
//                   color: Color(0xffb6b3b3),
//                 ),
//                 borderRadius: BorderRadius.all(Radius.circular(10))),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 //   Column(
//                 //     children: [
//                 //       Container(
//                 //         decoration: BoxDecoration(
//                 //             color: Colors.white, border: Border.all()),
//                 //         height: 80,
//                 //         child: Image.asset("assets/images/beta_profile.png"),
//                 //       ),
//                 //     ],
//                 //   ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(widget.receiverName,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                         )),
//                     SizedBox(
//                       height: 4,
//                     ),
//                     Container(
//                       width: 300,
//                       child: Flexible(
//                         child: Text(
//                           'Thanks for sending me a message Just leave your inquiries/message I\'ll",',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),

//                       // Column(
//                       //     crossAxisAlignment: CrossAxisAlignment.start,
//                       //     children: [
//                       //       Text('Thanks for sending me a message "CLIENT',
//                       //           style: TextStyle(
//                       //             fontSize: 12,
//                       //             fontWeight: FontWeight.w700,
//                       //           )),
//                       //       Text(
//                       //           "NAME! Just leave your inquiries/message I'll",
//                       //           style: TextStyle(
//                       //             fontSize: 12,
//                       //             fontWeight: FontWeight.w700,
//                       //           )),
//                       //       Text('check it later!',
//                       //           style: TextStyle(
//                       //             fontSize: 12,
//                       //             fontWeight: FontWeight.w700,
//                       //           )),
//                       //     ]),
//                     ),
//                     SizedBox(
//                       height: 4,
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           )
//         ]));
//   }

//   @override
//   Widget build(BuildContext context) {
//     createInput() {
//       return Container(
//           padding: EdgeInsets.all(16),
//           child: Row(
//             children: [
//               InkWell(
//                 onTap: () {
//                   print("HAHAHAHAHAHA");
//                   selectImage(context);
//                 },
//                 child: Icon(
//                   FontAwesomeIcons.plus,
//                   size: 30,
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   print("TAAAAAAAAAAAAAAAAAAAP");
//                   showPayment(context, widget.receiverId);
//                 },
//                 child: Icon(
//                   FontAwesomeIcons.moneyBillWaveAlt,
//                   size: 30,
//                 ),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Container(
//                 color: Color(0xffdfd1d1),
//                 height: 30,
//                 width: 250,
//                 child: TextField(
//                   style: TextStyle(
//                       fontSize: 14, height: 1.5, fontWeight: FontWeight.w700),
//                   controller: msgCtrl,
//                   cursorColor: Colors.greenAccent,
//                   decoration: InputDecoration(
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 0, horizontal: 15),
//                       hintText: "Enter Message here",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(0))),
//                   focusNode: focusNode,
//                 ),
//               ),
//               SizedBox(
//                 width: 3,
//               ),
//               InkWell(
//                 onTap: () => onSendMessage(msgCtrl.text, 0),
//                 child: Icon(
//                   Icons.send,
//                   size: 30,
//                 ),
//               ),
//             ],
//           ));
//     }

//     //Receiver msgs -left

// //else{
// //return

// //NEED
// //  Container(
// //      margin: EdgeInsets.only(bottom: 10.0),
// //      child: Column(
// //      crossAxisAlignment: CrossAxisAlignment.start,
// //      children: [Row(children: [],),isLastMsgLeft(index) ? Container(child: Text(DateFormat("dd MMMM, yyyy - hh:mm:aa").format(DateTime.fromMillisecondsSinceEpoch(int.parse(docs["timestamp"]))), style: const TextStyle(color: Colors.grey, fontSize: 12.0 ),),margin: EdgeInsets.only(left: 50.0, top: 50.0, bottom: 5.0),): Container() ]));
// //NEED

// //}

//     bool isLastMsgLeft(int index) {
//       if ((index > 0 &&
//               listMessage != null &&
//               listMessage[index - 1]["idFrom"] == userId) ||
//           index == 0) {
//         return true;
//       } else {
//         return false;
//       }
//     }

//     bool isLastMsgRight(int index) {
//       if ((index > 0 &&
//               listMessage != null &&
//               listMessage[index - 1]["idFrom"] != userId) ||
//           index == 0) {
//         return true;
//       } else {
//         return false;
//       }
//     }

//     Widget createItem(int index, DocumentSnapshot document) {
//       User user = _auth.currentUser!;
//       //My messages - Right Side
//       print("BAAAAAAAAAAAT<AM");
//       print(document.data());
//       print(user.uid);
//       print("BAAAAAAAAAAAT<AM");
//       if (document["idFrom"] == user.uid) {
//         print("TRUEEEEEEEEEEEEEEE");
//         return Row(
//           mainAxisAlignment: document["idFrom"] == user.uid
//               ? MainAxisAlignment.end
//               : MainAxisAlignment.start,
//           children: <Widget>[
//             document["type"] == 0 && document["idTo"] == widget.receiverId
//                 //Text

//                 ? Container(
//                     child: Text(
//                       "Sent: " + document["content"],
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.w500),
//                     ), // Text
//                     padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                     width: 200.0,
//                     decoration: BoxDecoration(
//                         color: Color(0xffffbe7d),
//                         borderRadius: BorderRadius.circular(8.0)),
//                     margin: EdgeInsets.only(
//                         bottom: isLastMsgRight(index) ? 20.0 : 10.0,
//                         right: 10.0),
//                   )
//                 //: Container()

//                 // Image Msg
//                 : document["type"] == 1 && document["idTo"] == widget.receiverId
//                     ? Container(
//                         margin: EdgeInsets.all(12),
//                         child: FlatButton(
//                             child: Material(
//                               child: Image.network(document["content"]),
//                               //   CachedNetworkImage(
//                               //     imageUrl: document["content"],
//                               //     progressIndicatorBuilder:
//                               //         (context, url, downloadProgress) =>
//                               //             CircularProgressIndicator(
//                               //                 value: downloadProgress.progress),
//                               //     errorWidget: (context, url, error) =>
//                               //         Icon(Icons.error),
//                               //   ),

//                               //    CachedNetworkImage(
//                               //     placeholder: (context, url) => Container(
//                               //       child: CircularProgressIndicator(
//                               //         valueColor: AlwaysStoppedAnimation<Color>(
//                               //             Colors.lightBlueAccent),
//                               //       ), //CircularProgressIndicator
//                               //       width: 200.0,
//                               //       height: 200.0,
//                               //       padding: EdgeInsets.all(70.0),
//                               //       decoration: BoxDecoration(
//                               //         color: Colors.grey,
//                               //         borderRadius:
//                               //             BorderRadius.all(Radius.circular(8.0)),
//                               //       ), //BoxDecoration
//                               //     ), //Container
//                               //     // errorWidget: (context, url, error) => Material(
//                               //     //   child: Image.asset(
//                               //     //       "images/img_not_available.jpg",
//                               //     //       width: 200.0,
//                               //     //       height: 200.0,
//                               //     //       fit: BoxFit.cover),
//                               //     //   borderRadius:
//                               //     //       BorderRadius.all(Radius.circular(8.0)),
//                               //     //   clipBehavior: Clip.hardEdge,
//                               //     // ), //Material
//                               //     imageUrl: document["content"],
//                               //     width: 200.0,
//                               //     height: 200.0,
//                               //     fit: BoxFit.cover,
//                               //   ), //ChacheNetwork Image
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(8.0)),
//                               clipBehavior: Clip.hardEdge,
//                             ), //Material
//                             onPressed: () {
//                               print(document["content"]);
//                             }
//                             // {
//                             // 	Navigator.push(context, MaterialPageRoute(
//                             // 		builder: (context) => FullPhoto(url: document["content"]);
//                             // 	)); //MaterialPageRoute
//                             // },
//                             ), //FlatButton
//                         //margin: EdgeInsets.only(bottom isLastMsgRight(index) ? 20.0 : 10.0, right: 10.0),
//                       ) //Container
//                     //Sticker .gif Msg
//                     : Container(
//                         // child: Image.asset(
//                         // 	"images/${document['container']}.gif",
//                         // 	width: 100.0,
//                         // 	height: 100.0,
//                         // 	fit: BoxFit.cover,
//                         // ),//Image.asset
//                         // margin: EdgeInsets.only(bottom isLastMsgRight(index) ? 20.0 : 10.0, right: 10.0),
//                         ), //container
//           ], //<Widget>[]
//         ); //Row
//       }
//       //Receiver Messages - Left Side
//       else {
//         return Container(
//             child: Column(children: <Widget>[
//           Row(children: <Widget>[
//             document["type"] == 0
//                 //Text
//                 ? Container(
//                     child: Text(
//                       "Received: " + document["content"],
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.w400),
//                     ), // Text
//                     padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                     width: 200.0,
//                     decoration: BoxDecoration(
//                         color: Color(0xff9dd4e5),
//                         borderRadius: BorderRadius.circular(8.0)),
//                     margin: EdgeInsets.only(left: 10.0, bottom: 10),
//                   )
//                 : Container()
//           ])
//         ]));
//       }
//     }

//     Widget createListMessages() {
//       User user = _auth.currentUser!;
//       return Scrollbar(
//         isAlwaysShown: true,
//         child: Container(
//           height: 460,
//           child: chatId == ""
//               ? const Center(
//                   child: CircularProgressIndicator(
//                   valueColor:
//                       AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
//                 ))
//               : StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection("messages")
//                       .doc(user.uid)
//                       .collection(user.uid)
//                       .orderBy("timestamp", descending: true)
//                       .limit(20)
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return const Center(
//                           child: Center(
//                               child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                             Colors.lightBlueAccent),
//                       )));
//                     } else {
//                       listMessage = snapshot.data!.docs;
//                       return ListView.builder(
//                         itemBuilder: (context, index) =>
//                             createItem(index, snapshot.data!.docs[index]),
//                         itemCount: snapshot.data!.docs.length,
//                         reverse: true,
//                         controller: listScrollCtrl,
//                       );
//                     }
//                   }),
//         ),
//       );
//     }

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         bottomSheet: createInput(),
//         resizeToAvoidBottomInset: false,
//         body: Center(
//           child: Container(
//             child: Column(
//               children: [
//                 WillPopScope(
//                     child:
//                         //  Stack(
//                         //   children: [
//                         Column(
//                       children: [
//                         top(),
//                         createListMessages(),
//                         SizedBox(
//                           height: 50,
//                         ),
//                       ],
//                     ),
//                     // ],
//                     //),
//                     onWillPop: null)
//                 //msgScreen()
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
