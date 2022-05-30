import 'package:flutter/material.dart';
//import '../../firebase/Fire_Auth.dart';
import '../../model/post.dart';
import 'post.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:la2enee_app1/model/user.dart';
import 'package:la2enee_app1/Module/Post/post.dart';

//TextStyle textStyle = const TextStyle(fontSize: 20, color: Colors.blue);

class PostCard extends StatefulWidget {
  final Post _post;

  const PostCard(this._post, {Key? key}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  PostModel? model;
  @override
  void initState() {
    //model = FireAuth().getPostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        // child: Image.network(
                        //   "${widget._post.user?.profileImage}",
                        //   fit: BoxFit.fill,
                        // ),
                      ),
                    )),
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget._post.user?.userName}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        DateFormat.yMMMd().format(widget._post.createdAt!),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const Expanded(flex: 1, child: Icon(Icons.more_vert)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "${widget._post.text}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                    "${widget._post.images?[0]}",
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                    "${widget._post.images?[1]}",
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.favorite_border),
                    ),
                    Text("${widget._post.likes}")
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.comment),
                    ),
                    Text("${widget._post.comments}")
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.share),
                    ),
                    Text("${widget._post.shares}")
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
