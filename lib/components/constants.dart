// POST
// UPDATE
// DELETE

// GET

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

// https://newsapi.org/v2/everything?q=tesla&apiKey=65f7f556ec76449fa7dc7c0069f040ca

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../Module/login/login_page.dart';
import 'components.dart';
import 'network/local/cache_helper.dart';

void signOut(context) {
  FirebaseAuth.instance.signOut();
  print("sign out sucsess");
  CacheHelper.removeData(
    key: 'uid',
  ).then((value) {
    uid = null;
    if (value) {
      navigateAndFinish(
        context,
        Login(),
      );
      // Phoenix.rebirth(context);
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';

String? uid = '';
