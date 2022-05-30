import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? userName;
  String? profileimage;
  String? uid;
  String? postImage;
  String? content;
  String? datetime;
  String? category;
  FieldValue? dateTime;
  PostModel({
    this.postImage,
    this.userName,
    this.profileimage,
    this.uid,
    this.datetime,
    this.content,
    this.category,
    this.dateTime,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    postImage = json["postImage"];
    content = json["content"];
    userName = json["userName"];
    datetime = json["datetime"];
    category = json["category"];
    profileimage = json["profileimage"];
    category = json["category"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "category": category,
      "postImage": postImage,
      "content": content,
      "userName": userName,
      "datetime": datetime,
      "profileimage": profileimage,
      "category": category,
      'dateTime': dateTime,
    };
  }
}