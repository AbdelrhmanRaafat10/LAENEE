import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:la2enee_app1/model/user.dart';

class Post {
  String? id;
  UserModel? user;
  String? text;
  List<String>? images;
  String? comments;
  String? shares;
  String? likes;
  DateTime? createdAt;
  Post({
    @required this.id,
    @required this.user,
    @required this.text,
    @required this.images,
    @required this.comments,
    @required this.shares,
    @required this.likes,
    @required this.createdAt,
  });
}
