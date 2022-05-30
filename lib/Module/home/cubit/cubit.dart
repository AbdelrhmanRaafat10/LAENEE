import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la2enee_app1/Module/Post/newpost.dart';
import 'package:la2enee_app1/Module/Profile/profile.dart';
import 'package:la2enee_app1/Module/chat/chat_page.dart';
import 'package:la2enee_app1/Module/home/cubit/states.dart';
import 'package:la2enee_app1/Module/home/home.dart';
import 'package:la2enee_app1/Module/login/login_page.dart';
import 'package:la2enee_app1/model/user.dart';

import '../../../components/components.dart';
import '../../../components/constants.dart';
import '../../../components/network/local/cache_helper.dart';
import '../../../model/MassageModel.dart';
import '../../../model/post.dart';
import '../../Notification/notifications.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../chat/Chat_Screen.dart';
import '../home22.dart';

class SocialCubit extends Cubit<SocialStates> {
  // SocialCubit() : super(SocialInitialState());
  SocialCubit(
    SocialStates initialState,
  ) : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      print(value.data);
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

////// New post screen
  String? category = 'Seeker';

  changeCategoryValue(cg) {
    category = cg;
    emit(SocialchangecategoryState());
  }

  //FeedsScreen
  int currentindex = 0;
  List<Widget> screens = [
    // Home(),
    FeedsScreen(),
    Profile(),
    NewPost(),
    Notifications(),
    // chat(),
    ChatsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Profile',
    'NewPost',
    'Notifications',
    'chat',
  ];

  void changeBottomNav(int index) {
    // if (index == 0 || index == 1) {
    //   getUserData();
    // }

    if (index == 2) {
      emit(SocialNewPostState());
    }
    /* else if (index == 4){
      getUsers();}*/
    else {
      currentindex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  Future<void> logOut({required context}) async {
    await FirebaseAuth.instance.signOut().then((value) {
      emit(SocialLogoutLoadingState());
      navigateAndRemove(context: context, widget: Login());
      emit(SocialLogoutSuccessState());
    }).catchError((error) {
      emit(SocialLogoutErrorState(error));
    });
  }

  Future<void> loginOut(context) async {
    // await FirebaseFirestore.instance.clearPersistence();

    await FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(key: 'uid').then((value) {
        uid = null;
        if (value) navigateAndFinish(context, Login());
      });

      emit(SocialLogoutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialLogoutErrorState(error));
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

// image_picker7901250412914563370.jpg

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  String profileimageUrl = '';

  void uploadProfileImage({
    required String userName,
    required String address,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUserdata(
            userName: userName, address: address, bio: bio, profile: value);
        profileimageUrl = value;
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadcoverImage({
    required String userName,
    required String address,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUserdata(
            userName: userName, address: address, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String userName,
  //   required String address,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (coverImage != null) {
  //     uploadcoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //   } else {
  //     updateUserdata(userName: userName, address: address, bio: bio);
  //   }
  // }

  void updateUserdata({
    required String userName,
    required String address,
    required String bio,
    String? cover,
    String? profile,
  }) {
    UserModel? model2 = UserModel(
      userName: userName,
      bio: bio,
      address: address,
      isEmailVerified: false,
      email: userModel?.email,
      uid: userModel?.uid,
      DateofBirth: userModel?.DateofBirth,
      gender: userModel?.gender,
      coverImage: cover ?? userModel?.coverImage,
      profileImage: profile ?? userModel?.profileImage,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(model2.toMap()!)
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  ////////////////////////////////////////////////////////
  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  Future<void> takePostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image taked.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String content,
    required String datetime,
    required String? category,
  }) {
    emit(SocialCreatePostLoadingState());

    // firebase_storage.FirebaseStorage.instance
    //     .ref()
    //     .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
    //     .putFile(postImage!)
    //     .then((value) {
    //   value.ref.getDownloadURL().then((value) {
    //     print(value);
    //     createPost(
    //       content: content,
    //       datetime: datetime,
    //       postImage: value,
    //       category: category,
    //     );
    if (category == 'Finder') {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('finderPosts/${Uri.file(postImage!.path).pathSegments.last}')
          .putFile(postImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          print(value);
          createPost(
            content: content,
            datetime: datetime,
            postImage: value,
            category: category,
          );
        }).catchError((error) {
          emit(SocialCreatePostErrorState());
        });
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    } else {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('seekerPosts/${Uri.file(postImage!.path).pathSegments.last}')
          .putFile(postImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          print(value);
          createPost(
            content: content,
            datetime: datetime,
            postImage: value,
            category: category,
          );
        }).catchError((error) {
          emit(SocialCreatePostErrorState());
        });
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }
  }

  void createPost({
    String? postImage,
    required String content,
    required String datetime,
    required String? category,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      userName: userModel?.userName,
      profileimage: userModel?.profileImage,
      uid: userModel?.uid,
      datetime: datetime,
      content: content,
      category: category,
      postImage: postImage ?? '',
      dateTime: FieldValue.serverTimestamp(),
    );
    FirebaseFirestore.instance
        .collection('Userposts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
      print('userPosts collicton');
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
    if (category == 'Finder') {
      FirebaseFirestore.instance
          .collection('finderPosts')
          .add(model.toMap())
          .then((value) {
        emit(SocialCreatePostSuccessState());
        print('FinderPosts collicton');
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    } else {
      FirebaseFirestore.instance
          .collection('seekerPosts')
          .add(model.toMap())
          .then((value) {
        emit(SocialCreatePostSuccessState());
        print('seekercollicton');
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }
  }

  List<PostModel> posts = [];
  List<String> postsID = [];
  List<int> likesCountList = [];

  void getFinderPosts() {
    // posts = [];
    // FirebaseFirestore.instance
    //     .collection('finderPosts')
    //     .orderBy('datetime', descending: true)
    //     .get()
    //     .then((value) {
    //   value.docs.forEach((element) {
    //     posts = [];
    //     element.reference.collection('Likes').get().then((value) {
    //       likesCountList.add(value.docs.length);
    //       postsID.add(element.id);
    //
    //       posts.add(PostModel.fromJson(element.data()));
    //     }).catchError((error) {});
    //   });
    //   emit(SocialGetPostsSuccessState());
    // }).catchError((error) {
    //   emit(SocialGetPostsErrorState(error.toString()));
    // });
    print("worked");
    posts = [];
    FirebaseFirestore.instance
        .collection('finderPosts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      posts = [];
      event.docs.forEach((element) {
        posts.add(PostModel.fromJson(element.data()));
        postsID.add(element.id);
        likesCountList.add(event.docs.length);
      });
      emit(SocialGetPostsSuccessState());
      print("FINDER " + "${posts.length}");
    });
  }

  ////////////////////
  // List<String> postsID2 = [];
  // List<PostModel> posts2 = [];
  // //List<int> likesCountList = [];
  // void getPosts() {
  //   FirebaseFirestore.instance
  //       .collection('finderPosts')
  //       .orderBy('dateTime', descending: true)
  //       .snapshots()
  //       .listen((event) async {
  //     posts2 = [];
  //     event.docs.forEach((element) async {
  //       element.reference.collection('Likes').get().then((value) {
  //         likesCountList.add(value.docs.length);
  //         postsID.add(element.id);
  //         posts.add(PostModel.fromJson(element.data()));
  //       }).catchError((error) {});
  //       //var comments = await element.reference.collection('comments').get();
  //     });
  //
  //     emit(SocialGetPostsSuccessState());
  //   });
  // }

  ////////////

  List<PostModel> seekerposts = [];
  List<String> seekerpostsID = [];
  List<int> seekerlikesCountList = [];
  void getSeekerPosts() {
    // seekerposts = [];
    // FirebaseFirestore.instance.collection('seekerPosts').get().then((value) {
    //   value.docs.forEach((element) {
    //     element.reference.collection('Likes').get().then((value) {
    //       seekerlikesCountList.add(value.docs.length);
    //       seekerpostsID.add(element.id);
    //       seekerposts.add(PostModel.fromJson(element.data()));
    //     }).catchError((error) {});
    //   });
    //   emit(SocialGetPostsSuccessState());
    // }).catchError((error) {
    //   emit(SocialGetPostsErrorState(error.toString()));
    // });
    seekerposts = [];
    FirebaseFirestore.instance
        .collection('seekerPosts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      seekerposts = [];
      event.docs.forEach((element) {
        seekerposts.add(PostModel.fromJson(element.data()));
        seekerpostsID.add(element.id);
        seekerlikesCountList.add(event.docs.length);
      });
      emit(SocialGetPostsSuccessState());
      print("SEKER " + "${seekerposts.length}");
    });
  }

  List<PostModel> userposts = [];
  List<PostModel> userpostsf = [];
  List<PostModel> userpostsS = [];

  void getUserPosts(String? userId) {
    // userposts = [];
    // FirebaseFirestore.instance.collection('finderPosts').get().then((value) {
    //   value.docs.forEach((element) {
    //     if (element.data()['uid'] == userId)
    //       userposts.add(PostModel.fromJson(element.data()));
    //
    //     element.reference.collection('Likes').get().then((value) {
    //       likesCountList.add(value.docs.length);
    //       postsID.add(element.id);
    //     }).catchError((error) {});
    //   });
    //   emit(SocialGetPostsSuccessState());
    // }).catchError((error) {
    //   emit(SocialGetPostsErrorState(error.toString()));
    // });
//
    userposts = [];
    FirebaseFirestore.instance
        .collection('Userposts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      userposts = [];
      event.docs.forEach((element) {
        if (element.data()['uid'] == userId)
          userposts.add(PostModel.fromJson(element.data()));
        postsID.add(element.id);
        likesCountList.add(event.docs.length);
      });

      emit(SocialGetPostsSuccessState());
    });

    // FirebaseFirestore.instance
    //     .collection('posts')
    //     .orderBy('dateTime')
    //     .snapshots()
    //     .listen((event) {
    //   userPosts = [];
    //   event.docs.forEach((element) {
    //     if (element.data()['uId'] == userId) {
    //       userPosts?.add(PostModel.fromJson(element.data()));
    //     }
    //   });
    //   emit(SocialGetuserPostsSuccessState());
    // });
  }

  // void getUserseekerPosts(String? userId) {
  //   userpostsS = [];
  //   FirebaseFirestore.instance
  //       .collection('seekerPosts')
  //       .orderBy('datetime', descending: true)
  //       .snapshots()
  //       .listen((event) {
  //     userpostsS = [];
  //     // userposts = [];
  //     event.docs.forEach((element) {
  //       if (element.data()['uid'] == userId)
  //         userpostsS.add(PostModel.fromJson(element.data()));
  //       seekerpostsID.add(element.id);
  //       seekerlikesCountList.add(event.docs.length);
  //     });
  //     emit(SocialGetPostsSuccessState());
  //   });
  // }

  void likePost(String postID) {
    FirebaseFirestore.instance
        .collection('finderPosts')
        .doc(postID)
        .collection('Likes')
        .doc(userModel?.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void likePostSeeker(String postID) {
    FirebaseFirestore.instance
        .collection('seekerPosts')
        .doc(postID)
        .collection('Likes')
        .doc(userModel?.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  UserModel? friendsProfile;

  void getFriendsProfile(String? friendsUid) {
    emit(GetFriendProfileLoadingState());
    FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      value.docs.forEach((element) {
        if (element.data()['uid'] == friendsUid)
          friendsProfile = UserModel.fromJson(element.data());
      });
      emit(GetFriendProfileSuccessState());
    });
  }
///////////////////////////////////////////////////////////////////neeew hamada ///////

  List<UserModel> users = [];
  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((value) {
        users = [];
        value.docs.forEach((element) {
          if (element.data()['uid'] != userModel?.uid)
            users.add(UserModel.fromJson(element.data()));
        });

        emit(SocialGetAllUsersSuccessState());
        // }).catchError((error) {
        //   print(error.toString());
        //   emit(SocialGetAllUsersErrorState(error.toString()));
      });
  }

  void sendMessage({
    required String? receiverId,
    required String? dateTime,
    required String? text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel?.uid,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String? receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessagesSuccessState());
    });
  }
}
