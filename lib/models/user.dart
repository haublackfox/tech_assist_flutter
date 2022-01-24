import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String nickname;
  final String photoUrl;
  final String createdAt;

  User({
    required this.id,
    required this.nickname,
    required this.photoUrl,
    required this.createdAt,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.id,
      photoUrl: doc['photoUrl'],
      nickname: doc['nickname'],
      createdAt: doc['createdAt'],
    );
  }
}
