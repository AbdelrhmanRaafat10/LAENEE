import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Firebase_Messaging extends StatefulWidget {
  @override
  _Firebase_MessagingState creatState() => _Firebase_MessagingState();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _Firebase_MessagingState extends State<Firebase_Messaging> {
  // final +FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    configureCallback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  void configureCallback() {
    //_firebaseMessaging.configure(onMessage: (message) async {});
  }
}
