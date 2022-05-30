import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:la2enee_app1/Module/Profile/EditProfileScreen.dart';
import 'package:la2enee_app1/Module/Profile/editpro.dart';
import 'package:la2enee_app1/Module/home/cubit/cubit.dart';
import 'package:la2enee_app1/Module/home/cubit/states.dart';
import 'package:la2enee_app1/components/components.dart';
import 'package:la2enee_app1/Module/home/home22.dart';
import '../../components/constants.dart';
import '../../model/post.dart';

import '../chat/chat_details_screen.dart';
import '../login/cubit/states.dart';

var userModel;
var friendsModel;

class userProfile extends StatelessWidget {
  // const userProfile({Key? key}) : super(key: key);
  String? userUid;
  userProfile(this.userUid);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getUserPosts(userUid);
      // SocialCubit.get(context).getUserseekerPosts(userUid);
      SocialCubit.get(context).getFriendsProfile(userUid);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is SocialLoginSuccessState) {
            FirebaseFirestore.instance.collection('users').doc(uid).get();
            userModel = SocialCubit.get(context).friendsProfile;
            userModel.uid = userUid;
            friendsModel = SocialCubit.get(context).friendsProfile;
          }
        },
        builder: (context, state) {
          FirebaseFirestore.instance.collection('users').doc(uid).get();
          friendsModel = SocialCubit.get(context).friendsProfile;
          userModel = SocialCubit.get(context).friendsProfile;
          // FirebaseFirestore.instance.collection('users').doc(uid).get();
          //Phoenix.rebirth(context);s
          // var model = SocialCubit.get(context).model;

          return Scaffold(
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
              elevation: 5.0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: Text('${friendsModel?.userName}\'s profile '),
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
                    SocialCubit.get(context).currentindex = 0;
                    signOut(context);
                    // SocialCubit.get(context).logOut(context: context);
                    //SocialCubit.get(context).loginOut(context);
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 190.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: Container(
                              height: 140.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    4.0,
                                  ),
                                  topRight: Radius.circular(
                                    4.0,
                                  ),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '${friendsModel?.coverImage}',
                                    //'https://i.pinimg.com/originals/30/5c/5a/305c5a457807ba421ed67495c93198d3.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(
                                '${friendsModel?.profileImage}',
                                //'https://i.pinimg.com/originals/30/5c/5a/305c5a457807ba421ed67495c93198d3.jpg',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${friendsModel?.userName}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      '${friendsModel?.bio}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      '${friendsModel?.address}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     vertical: 20.0,
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: InkWell(
                    //           child: Column(
                    //             children: [
                    //               Text(
                    //                 '100',
                    //                 style: Theme.of(context).textTheme.subtitle2,
                    //               ),
                    //               Text(
                    //                 'Posts',
                    //                 style: Theme.of(context).textTheme.caption,
                    //               ),
                    //             ],
                    //           ),
                    //           onTap: () {},
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: InkWell(
                    //           child: Column(
                    //             children: [
                    //               Text(
                    //                 '265',
                    //                 style: Theme.of(context).textTheme.subtitle2,
                    //               ),
                    //               Text(
                    //                 'Photos',
                    //                 style: Theme.of(context).textTheme.caption,
                    //               ),
                    //             ],
                    //           ),
                    //           onTap: () {},
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: InkWell(
                    //           child: Column(
                    //             children: [
                    //               Text(
                    //                 '10k',
                    //                 style: Theme.of(context).textTheme.subtitle2,
                    //               ),
                    //               Text(
                    //                 'Followers',
                    //                 style: Theme.of(context).textTheme.caption,
                    //               ),
                    //             ],
                    //           ),
                    //           onTap: () {},
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: InkWell(
                    //           child: Column(
                    //             children: [
                    //               Text(
                    //                 '64',
                    //                 style: Theme.of(context).textTheme.subtitle2,
                    //               ),
                    //               Text(
                    //                 'Followings',
                    //                 style: Theme.of(context).textTheme.caption,
                    //               ),
                    //             ],
                    //           ),
                    //           onTap: () {},
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            side: BorderSide(
                              width: 0,
                            ),
                          ),
                          onPressed: () {
                            navigateTo(
                              context,
                              ChatDetailsScreen(
                                userModel: friendsModel,
                              ),
                            );
                            //  navigateTo(context, ChatScreen1(userModel: friendsModel,));
                          },
                          child: Text(
                            'contact',
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        // Expanded(
                        //   child: OutlinedButton(
                        //     style: OutlinedButton.styleFrom(
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(18.0),
                        //       ),
                        //       side: BorderSide(
                        //         width: 0,
                        //       ),
                        //     ),
                        //     onPressed: () {
                        //       // print(model.email);
                        //       // print(model.uid);
                        //       // print(model.bio);
                        //       navigateTo(
                        //         context,
                        //         edit(),
                        //         // EditProfileScreen(),
                        //       );
                        //     },
                        //     child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Text(
                        //             'Edit',
                        //           ),
                        //           SizedBox(
                        //             width: 10.0,
                        //           ),
                        //           Icon(
                        //             Icons.edit,
                        //             size: 16.0,
                        //           ),
                        //         ]),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFECF8FF),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          )),
                      child: Column(
                        children: [
                          // Card(
                          //   clipBehavior: Clip.antiAliasWithSaveLayer,
                          //   elevation: 5.0,
                          //   margin: EdgeInsets.all(
                          //     10.0,
                          //   ),
                          //   child: Stack(
                          //     alignment: AlignmentDirectional.bottomEnd,
                          //     children: [
                          //       Image(
                          //         image: NetworkImage(
                          //             'https://images.unsplash.com/photo-1586769852836-bc069f19e1b6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZmluZHxlbnwwfHwwfHw%3D&w=1000&q=80'),
                          //         fit: BoxFit.cover,
                          //         height: 200.0,
                          //         width: double.infinity,
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Text(
                          //           'Finding the missing one',
                          //           style: Theme.of(context)
                          //               .textTheme
                          //               .subtitle1!
                          //               .copyWith(
                          //                 color: Colors.white,
                          //               ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          if (SocialCubit.get(context).userposts.length != 0 &&
                              SocialCubit.get(context).userpostsS.length != 0)
                            SizedBox(
                              height: 8.0,
                            ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => buildPostItem(
                                SocialCubit.get(context).userposts[index],
                                context,
                                index),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 8.0,
                            ),
                            itemCount:
                                SocialCubit.get(context).userposts.length,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                buildseekerPostItem(
                                    SocialCubit.get(context).userpostsS[index],
                                    context,
                                    index),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 8.0,
                            ),
                            itemCount:
                                SocialCubit.get(context).userpostsS.length,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          if (SocialCubit.get(context).userposts.length == 0 &&
                              SocialCubit.get(context).userpostsS.length == 0)
                            Text(
                              'No posts yet ',
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

Widget buildPostItem(PostModel model, context, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    '${model.profileimage}',
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.userName}',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${model.datetime}',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      height: 1.4,
                                    ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            '(${model.category})',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      height: 1.4,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.content}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     bottom: 10.0,
            //     top: 5.0,
            //   ),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 6.0,
            //           ),
            //           child: Container(
            //             height: 25.0,
            //             child: MaterialButton(
            //               onPressed: () {},
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               child: Text(
            //                 '#software',
            //                 style:
            //                     Theme.of(context).textTheme.caption!.copyWith(
            //                           color: Colors.blue,
            //                         ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 6.0,
            //           ),
            //           child: Container(
            //             height: 25.0,
            //             child: MaterialButton(
            //               onPressed: () {},
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               child: Text(
            //                 '#flutter',
            //                 style:
            //                     Theme.of(context).textTheme.caption!.copyWith(
            //                           color: Colors.blue,
            //                         ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 15.0,
                ),
                child: Container(
                  height: 140.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.postImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 16.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).likesCountList[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.message_rounded,
                              size: 16.0,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '0 comment',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel?.profileImage}',
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'write a comment ...',
                          style:
                              Theme.of(context).textTheme.caption!.copyWith(),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 16.0,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: () {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postsID[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
Widget buildseekerPostItem(PostModel model, context, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    '${model.profileimage}',
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.userName}',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${model.datetime}',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      height: 1.4,
                                    ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            '(${model.category})',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      height: 1.4,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.content}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     bottom: 10.0,
            //     top: 5.0,
            //   ),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 6.0,
            //           ),
            //           child: Container(
            //             height: 25.0,
            //             child: MaterialButton(
            //               onPressed: () {},
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               child: Text(
            //                 '#software',
            //                 style:
            //                     Theme.of(context).textTheme.caption!.copyWith(
            //                           color: Colors.blue,
            //                         ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 6.0,
            //           ),
            //           child: Container(
            //             height: 25.0,
            //             child: MaterialButton(
            //               onPressed: () {},
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               child: Text(
            //                 '#flutter',
            //                 style:
            //                     Theme.of(context).textTheme.caption!.copyWith(
            //                           color: Colors.blue,
            //                         ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 15.0,
                ),
                child: Container(
                  height: 140.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.postImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 16.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).seekerlikesCountList[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.message_rounded,
                              size: 16.0,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '0 comment',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel?.profileImage}',
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'write a comment ...',
                          style:
                              Theme.of(context).textTheme.caption!.copyWith(),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 16.0,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: () {
                    SocialCubit.get(context).likePostSeeker(
                        SocialCubit.get(context).seekerpostsID[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
