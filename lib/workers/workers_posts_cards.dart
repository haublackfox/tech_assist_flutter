import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist_flutter_next/screens/chat_page.dart';
import 'package:tech_assist_flutter_next/screens/chatting_page.dart';

class WorkersPostsCard extends StatefulWidget {
  const WorkersPostsCard({Key? key}) : super(key: key);

  @override
  _WorkersPostsCardState createState() => _WorkersPostsCardState();
}

class _WorkersPostsCardState extends State<WorkersPostsCard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int to_ship = 0;
  int receive = 0;
  int completed = 0;
  int cancel = 0;
  int refund = 0;

  @override
  Widget build(BuildContext context) {
    List posts = [];
    User user = _auth.currentUser!;
    return Container(
      height: 10,
      child: Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("posts")
                //.doc(user.uid)
                // .collection(user.uid)
                .orderBy(
                  'timestamp',
                  descending: true,
                )
                .snapshots(),
            // collection('messages').snapshots(),

            //  .collection("messages")
            //     .doc(user.uid)
            //     .collection(user.uid)
            builder: (ctx,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    streamSnapshots) {
              if (streamSnapshots.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final documents = streamSnapshots.data!.docs;

              posts = [];

              documents.forEach((doc) {
                posts.add([
                  doc.data()["id"], //0
                  doc.data()["poster_id"], //1
                  doc.data()["name"], //2
                  doc.data()["msg"], //3
                  doc.data()["createdAt"], //4
                  doc.data()["timePosted"], //5
                  doc.data()["imageurl"], //6
                  doc.data()["timestamp"],
                  //   doc.data()["senders_image"], //6
                  //   doc.data()["receiver_name"], //7
                  //   doc.data()["receiver_image"], //8
                ]);
                // }
              });

              print("HAAAAAAAAAAAAAAAAAAAAAA");
              //   print(documents);
              print(posts);

              print("HAAAAAAAAAAAAAAAAAAAAAA");

              print("bbbbbbbbbbbbbbb");
              //   print(documents);
              print(posts);

              print("bbbbbbbbbbbbbbbbbbbbb");

              return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                              color: Color(0xfff9f2f2),
                              border: Border.all(
                                color: Color(0xffb6b3b3),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: ListTile(
                            leading: Container(
                              // height: 80,
                              width: 70,
                              child: ClipOval(
                                  child: Material(
                                      color: Colors.blue,
                                      child: posts[index][6].toString() != ''
                                          ? Image.network(
                                              posts[index][6].toString(),
                                              fit: BoxFit.fitHeight,
                                            )
                                          : Center(
                                              child: Container(
                                                // padding:
                                                //     const EdgeInsets.symmetric(
                                                //         horizontal: 36,
                                                //         vertical: 26),
                                                child: Text(
                                                    posts[index][5].toString()[
                                                        0], //userInfos[0].email[0] ?? '',
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white)),
                                              ),
                                            ))),
                            ),
                            title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "    " + posts[index][2].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    // padding: EdgeInsets.symmetric(
                                    //     vertical: 8, horizontal: 8),
                                    //   Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffdfd1d1).withAlpha(150),
                                      border: Border.all(

                                          //color: Colors.red[500],
                                          ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    height: 100,
                                    width: 260,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            posts[index][3].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          ElevatedButton(
                                              onPressed: () async {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChattingPage(
                                                              receiverId: posts[
                                                                      index][1]
                                                                  .toString(),
                                                              receiverName:
                                                                  posts[index]
                                                                          [2]
                                                                      .toString(),
                                                            )));
                                              },
                                              child: Text("MESSAGE ME",
                                                  style: GoogleFonts.roboto(
                                                      letterSpacing: 2,
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              style: ElevatedButton.styleFrom(
                                                side: BorderSide(
                                                    width: 1.0,
                                                    color: Color(0xfffafafa)),
                                                shape: StadiumBorder(),
                                                primary: Color(0xfff5970a),
                                              )),
                                          Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                posts[index][5].toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[700],
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ]),
                                  ),
                                ]),
                          ),

                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          // Column(
                          //   children: [
                          //     Container(
                          //       height: 80,
                          //       width: 80,
                          //       child: ClipOval(
                          //           child: Material(
                          //               color: Colors.blue,
                          //               child: posts[index][6]
                          //                           .toString() !=
                          //                       ''
                          //                   ? Image.network(
                          //                       posts[index][6]
                          //                           .toString(),
                          //                       fit: BoxFit.fitHeight,
                          //                     )
                          //                   : Center(
                          //                       child: Container(
                          //                         padding:
                          //                             const EdgeInsets
                          //                                     .symmetric(
                          //                                 horizontal: 36,
                          //                                 vertical: 26),
                          //                         child: Text(
                          //                             posts[index][5]
                          //                                     .toString()[
                          //                                 0], //userInfos[0].email[0] ?? '',
                          //                             style:
                          //                                 const TextStyle(
                          //                                     fontSize:
                          //                                         15,
                          //                                     color: Colors
                          //                                         .white)),
                          //                       ),
                          //                     ))),
                          //     )
                          //   ],
                          // ),
                          //     SizedBox(
                          //       width: 20,
                          //     ),
                          //     Column(
                          //         crossAxisAlignment:
                          //             CrossAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             "    " + posts[index][2].toString(),
                          //             style: TextStyle(
                          //                 fontWeight: FontWeight.bold),
                          //           ),
                          //           SizedBox(
                          //             height: 8,
                          //           ),
                          //           Container(
                          //             // padding: EdgeInsets.symmetric(
                          //             //     vertical: 8, horizontal: 8),
                          //             //   Container(
                          //             decoration: BoxDecoration(
                          //               color:
                          //                   Color(0xffdfd1d1).withAlpha(150),
                          //               border: Border.all(

                          //                   //color: Colors.red[500],
                          //                   ),
                          //               borderRadius: BorderRadius.all(
                          //                   Radius.circular(10)),
                          //             ),
                          //             height: 100,
                          //             width: 260,
                          //             child: Column(
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.center,
                          //                 children: [
                          //                   Text(
                          //                     posts[index][3].toString(),
                          //                     style: TextStyle(
                          //                         fontWeight:
                          //                             FontWeight.bold),
                          //                   ),
                          //                   Spacer(),
                          //                   ElevatedButton(
                          //                       onPressed: () async {
                          //                         Navigator.push(
                          //                             context,
                          //                             MaterialPageRoute(
                          //                                 builder:
                          //                                     (context) =>
                          //                                         ChattingPage(
                          //                                           receiverId:
                          //                                               posts[index][1]
                          //                                                   .toString(),
                          //                                           receiverName:
                          //                                               posts[index][2]
                          //                                                   .toString(),
                          //                                         )));
                          //                       },
                          //                       child: Text("MESSAGE ME",
                          //                           style: GoogleFonts.roboto(
                          //                               letterSpacing: 2,
                          //                               fontSize: 14,
                          //                               color: Colors.white,
                          //                               fontWeight:
                          //                                   FontWeight.w700)),
                          //                       style:
                          //                           ElevatedButton.styleFrom(
                          //                         side: BorderSide(
                          //                             width: 1.0,
                          //                             color:
                          //                                 Color(0xfffafafa)),
                          //                         shape: StadiumBorder(),
                          //                         primary: Color(0xfff5970a),
                          //                       )),
                          //                   Row(
                          //                     children: [
                          //                       Spacer(),
                          //                       Text(
                          //                         posts[index][5].toString(),
                          //                         style: TextStyle(
                          //                             fontSize: 12,
                          //                             color: Colors.grey[700],
                          //                             fontWeight:
                          //                                 FontWeight.bold),
                          //                       ),
                          //                     ],
                          //                   )
                          //                 ]),
                          //           ),
                          //         ])
                          //   ],
                          // )
                        ),
                      ));
            }),
      ),
    );
  }
}
