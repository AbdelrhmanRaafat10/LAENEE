import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:la2enee_app1/Module/home/home22.dart';
import 'package:la2enee_app1/Module/login/cubit/cubit.dart';

import 'package:la2enee_app1/components/components.dart';
import 'package:la2enee_app1/components/constants.dart';
import 'package:la2enee_app1/main.dart';
//import 'package:la2enee_test/firebase/Fire_Auth.dart';

import '../../model/post.dart';
import '../Notification/notifications.dart';
import '../Post/newpost.dart';
import '../Post/post.dart';
import '../Profile/profile.dart';
import '../chat/Chat_Screen.dart';
import '../chat/chat_page.dart';
import '../login/cubit/states.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'home.dart';
import 'package:intl/intl.dart';
import 'package:la2enee_app1/model/user.dart';

class MyHomePage extends StatelessWidget {
  // const MyHomePage ({Key? key}) : super(key: key);
  PostModel? model;
  int _selectedIndex = 0;
  // FeedsScreen
  final List<Map<String, Object>> _pages = [
    // {'page': const Home(), 'title': "Home"},
    {'page': const FeedsScreen(), 'title': "Home"},
    {'page': const Profile(), 'title': "Profile"},
    {'page': NewPost(), 'title': "NewPost"},
    {'page': const Notifications(), 'title': "Notifications"},
    //{'page': const chat(), 'title': "Chat"},
    {'page': ChatsScreen(), 'title': "Chat"},
  ];

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
  //               "https://cdn-icons-png.flaticon.com/512/194/194828.png"),
  //       images: [
  //         "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/400px-Andrzej_Person_Kancelaria_Senatu.jpg",
  //         "https://upload.wikimedia.org/wikipedia/commons/9/9c/Andrzej_Person_2012.jpg"
  //       ],
  //       createdAt: DateTime.now(),
  //       text: 'Hi Every one I need your help',
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
  //       text: 'Hi Every one I need your help',
  //       comments: "20",
  //       id: "0",
  //       likes: "12K",
  //       shares: "12")
  // ];

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        await flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                color: Colors.blue,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: "@mipmap/ic_launcher",
              ),
            ));
        await showDialog(
            context: context,
            builder: (_) {
              Future.delayed(
                Duration(seconds: 2),
                () {
                  Navigator.of(context).pop(true);
                },
              );

              return AlertDialog(
                alignment: Alignment.topCenter,
                title: Text("${notification.title}"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("${notification.body}")],
                  ),
                ),
              );
            });
      }
    });

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => SocialLoginCubit()),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is SocialNewPostState) {
            navigateTo(context, NewPost());
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          if (SocialLoginCubit.get(context).getdata == false) {
            SocialCubit.get(context).getUserData();
            //SocialCubit.get(context).getUsers();
            // SocialCubit.get(context).getSeekerPosts();
            // SocialCubit.get(context).getFinderPosts();
            //  SocialCubit.get(context).getPosts();
            SocialLoginCubit.get(context).getdata = true;
          }
          print(SocialLoginCubit.get(context).getdata);
          //
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                // bottom: TabBar(
                //   indicatorColor: Colors.blue,
                //   labelColor: Colors.black,
                //   tabs: [
                //     Tab(
                //       text: 'finder',
                //     ),
                //     Tab(
                //       text: 'seeker',
                //     ),
                //   ],
                // ),
                elevation: 0.0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                title: Text(cubit.titles[cubit.currentindex]),
                actions: [
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(Icons.search_outlined),
                        onPressed: () {
                          print(uid);
                        },
                      )),
                  IconButton(
                    icon: Icon(Icons.ac_unit_outlined),
                    onPressed: () {
                      cubit.currentindex = 0;
                      signOut(context);
                      // SocialCubit.get(context).logOut(context: context);
                      //SocialCubit.get(context).loginOut(context);
                    },
                  )
                ],
              ),
              body: cubit.screens[cubit.currentindex],
              drawer: Drawer(
                child: ListView(),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentindex,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.black,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_rounded), label: "Profile"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_circle_outline), label: "Add"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.notifications_outlined),
                      label: "Notifications"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat_outlined), label: "Chat"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
