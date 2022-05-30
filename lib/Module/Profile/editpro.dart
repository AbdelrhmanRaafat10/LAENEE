import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la2enee_app1/Module/home/cubit/cubit.dart';
import 'package:la2enee_app1/Module/home/cubit/cubit.dart';
import 'package:la2enee_app1/Module/home/cubit/cubit.dart';
import 'package:la2enee_app1/Module/home/cubit/cubit.dart';
import 'package:la2enee_app1/Module/home/cubit/states.dart';

import '../../components/components.dart';
import '../home/cubit/cubit.dart';

class edit extends StatelessWidget {
  edit({Key? key}) : super(key: key);
  var userNameController = TextEditingController();
  var bioController = TextEditingController();
  var addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        userNameController.text = '${userModel?.userName}';
        bioController.text = '${userModel?.bio}';
        addressController.text = '${userModel?.address}';
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'edit profile', actions: [
            defaultTextButton(
              function: () {
                if (SocialCubit.get(context).profileImage != null &&
                    SocialCubit.get(context).coverImage != null) {
                  SocialCubit.get(context).uploadProfileImage(
                      userName: userNameController.text,
                      address: addressController.text,
                      bio: bioController.text);
                  SocialCubit.get(context).uploadcoverImage(
                      userName: userNameController.text,
                      address: addressController.text,
                      bio: bioController.text);
                } else if (SocialCubit.get(context).profileImage != null) {
                  SocialCubit.get(context).uploadProfileImage(
                      userName: userNameController.text,
                      address: addressController.text,
                      bio: bioController.text);
                } else if (SocialCubit.get(context).coverImage != null) {
                  SocialCubit.get(context).uploadcoverImage(
                      userName: userNameController.text,
                      address: addressController.text,
                      bio: bioController.text);
                } else {
                  SocialCubit.get(context).updateUserdata(
                      userName: userNameController.text,
                      address: addressController.text,
                      bio: bioController.text);
                }
              },
              text: 'update',
            ),
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
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
                                      image: coverImage == null
                                          ? NetworkImage(
                                              '${userModel?.coverImage}',
                                            )
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 20.0,
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 16.0,
                                      ),
                                    ))
                              ]),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(
                                          '${userModel?.profileImage}',
                                          //'https://i.pinimg.com/originals/30/5c/5a/305c5a457807ba421ed67495c93198d3.jpg',
                                        )
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 20.0,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 16.0,
                                    ),
                                  )),
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  defaultFormField(
                    controller: userNameController,
                    type: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icon(
                      Icons.person,
                      color: Color(0xFF125BE4),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    label: 'bio',
                    prefix: Icon(
                      Icons.info,
                      color: Color(0xFF125BE4),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: addressController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'address must not be empty';
                      }
                      return null;
                    },
                    label: 'address',
                    prefix: Icon(
                      Icons.home_filled,
                      color: Color(0xFF125BE4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
