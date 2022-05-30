import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../components/components.dart';
import '../Profile/profile.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/states.dart';
import '../home/home22.dart';
import '../home/main_page.dart';
import 'package:dio/dio.dart' as dio;
//import '../../firebase/Fire_Auth.dart';

class NewPost extends StatelessWidget {
  void postHttp(var file, uid, x) async {
    var url = 'http://10.0.2.2:5000/';
    if (x == "Seeker") {
      url = url + "seekerPost";
    }
    if (x == "Finder") {
      url = url + "finderPost";
    }
    try {
      var formData = dio.FormData.fromMap({
        'uid': uid,
        'file': dio.MultipartFile.fromBytes(file.readAsBytesSync(),
            filename: "messi.png")
      });
      var response = await dio.Dio().post(
        url,
        data: formData,
      );
      print(response);
    } catch (e) {
      print(e);
    }
  }

  NewPost({Key? key}) : super(key: key);
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        userModel = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                function: () {
                  var now = DateTime.now();
                  String formattedDate =
                      //  DateFormat.jm().format(DateTime.now()),
                      DateFormat.yMMMd().add_jm().format(now);
                  //  DateFormat('yyyy-MM-dd – kk:mm: a').format(now);

                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      datetime: formattedDate,
                      content: textController.text,
                      category: SocialCubit.get(context).category,
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                      datetime: formattedDate,
                      content: textController.text,
                      category: SocialCubit.get(context).category,
                    );
                  }
                  var uid = userModel.uid;
                  var file = SocialCubit.get(context).postImage;
                  var x = SocialCubit.get(context).category;
                  postHttp(file, uid, x);

                  navigateAndFinish(
                    context,
                    MyHomePage(),
                  );
                },
                text: 'Post',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        '${userModel?.profileImage}',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        '${userModel?.userName}',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Select Category'),
                        DropdownButton<String>(
                          value: SocialCubit.get(context).category,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(color: Colors.blue),
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                          onChanged: (String? newValue) {
                            SocialCubit.get(context)
                                .changeCategoryValue(newValue);
                          },
                          items: <String>['Seeker', 'Finder']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 30,
                    //ergerh maxLength: 2000,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            4.0,
                          ),
                          image: DecorationImage(
                            image:
                                FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 16.0,
                          ),
                        ),
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'add photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).takePostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'take photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
