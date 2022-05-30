import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la2enee_app1/Module/home/cubit/cubit.dart';
import 'package:la2enee_app1/Module/home/cubit/cubit.dart';
import 'package:la2enee_app1/Module/home/cubit/cubit.dart';
import 'package:la2enee_app1/Module/home/cubit/cubit.dart';
import 'package:la2enee_app1/Module/home/cubit/states.dart';

import '../../components/components.dart';
import '../home/cubit/cubit.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        // nameController.text = '${userModel?.userName}';
        // bioController.text = '${userModel?.bio}';
        // phoneController.text = userModel.phone;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: 15.0,
                ),
                child: defaultTextButton(
                  function: () {
                    // SocialCubit.get(context).updateUser(
                    //   name: nameController.text,
                    //   phone: phoneController.text,
                    //   bio: bioController.text,
                    // );
                  },
                  text: 'Update',
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage(
                                              '${userModel?.coverImage}')
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                    ? NetworkImage('${userModel?.profileImage}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    // SocialCubit.get(context).uploadProfileImage(
                                    //   name: nameController.text,
                                    //   phone: phoneController.text,
                                    //   bio: bioController.text,
                                    // );
                                  },
                                  text: 'upload profile ',
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    // SocialCubit.get(context).uploadCoverImage(
                                    //   name: nameController.text,
                                    //   phone: phoneController.text,
                                    //   bio: bioController.text,
                                    // );
                                  },
                                  text: 'upload cover ',
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    const SizedBox(
                      height: 20.0,
                    ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icon(
                      Icons.person,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix: Icon(
                      Icons.info,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // defaultFormField(
                  //   controller: phoneController,
                  //   type: TextInputType.phone,
                  //   validate: (String value) {
                  //     if (value.isEmpty) {
                  //       return 'phone must not be empty';
                  //     }
                  //     return null;
                  //   },
                  //   label: 'Phone',
                  //   prefix: IconBroken.Call,
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
