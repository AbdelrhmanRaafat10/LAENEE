import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class chat extends StatelessWidget {
  const chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFECF8FF),
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Color(0xFFECF8FF), //Colors.white,
            elevation: 0.0,
            title: Row(
              children: [
                SizedBox(width: 30),
                Text(
                  "Messages",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontSize: 40.0,
                    // fontWeight: FontWeight.bold,
                    // ignore: prefer_const_constructors
                    color: Colors.black,
                  ),
                ),
              ],
            )),
        body: SafeArea(
            child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  )),
              child: Container(
                width: 500.0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            SizedBox(
                              width: 10.0,
                            ),
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'https://avatars.githubusercontent.com/u/43284764?s=400'),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                bottom: 3.0,
                                end: 3.0,
                              ),
                              child: CircleAvatar(
                                radius: 7.0,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ])));
  }
}
