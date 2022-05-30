import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
//import 'package:la2enee_app1/Home/post.dart';
import 'package:la2enee_app1/model/user.dart';
import '../Post/post.dart';
import '../Post/post_card.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static String title = "Home";

  // List<Post> posts = [
  //   Post(
  //       user: UserModel(
  //           uid: "0",
  //           userName: "Ahmed Ali",
  //           city: "address",
  //           birthDate :"birthDate",
  //           email: "email",
  //           gender: "male",
  //           isEmailVerified: true,
  //           profileImage:
  //           "https://cdn-icons-png.flaticon.com/512/194/194828.png"),
  //       images: [
  //         "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/400px-Andrzej_Person_Kancelaria_Senatu.jpg",
  //         "https://upload.wikimedia.org/wikipedia/commons/9/9c/Andrzej_Person_2012.jpg"
  //       ],
  //       createdAt: DateTime.now(),
  //       text: 'Hi Everyone, I need your help',
  //       comments: "20",
  //       likes: "5K",
  //       id: "0",
  //       shares: "12"),
  //   Post(
  //       user: UserModel(
  //           uid: "1",
  //           userName: "Bassma Ahmed",
  //           city: "address",
  //           birthDate :"birthDate",
  //           isEmailVerified: true,
  //           email: "email",
  //           gender: "female",
  //           profileImage:
  //           "https://icons-for-free.com/iconfiles/png/512/female+person+user+woman+young+icon-1320196266256009072.png"),
  //       images: [
  //         "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/400px-Andrzej_Person_Kancelaria_Senatu.jpg",
  //         "https://upload.wikimedia.org/wikipedia/commons/9/9c/Andrzej_Person_2012.jpg"
  //       ],
  //       createdAt: DateTime.now(),
  //       text: 'Hi Everyone, I need your help',
  //       comments: "20",
  //       id: "0",
  //       likes: "12K",
  //       shares: "12")
  // ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFECF8FF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  )),
              height: double.infinity,
              child: Card(
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
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/400px-Andrzej_Person_Kancelaria_Senatu.jpg",
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "aliS",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text('5/9/200'
                                    // DateFormat.yMMMd().format(),
                                    // style: Theme.of(context).textTheme.titleMedium,
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
                          "hellow",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Row(children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.network(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/400px-Andrzej_Person_Kancelaria_Senatu.jpg",
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
                              Text("7")
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.comment),
                              ),
                              Text("5")
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.share),
                              ),
                              Text("6")
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
