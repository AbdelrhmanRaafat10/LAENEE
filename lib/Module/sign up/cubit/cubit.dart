import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la2enee_app1/Module/sign%20up/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:la2enee_app1/model/user.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String userName,
    required String email,
    required String password,
    required String DateofBirth,
    required String gender,
    required String address,
    required String token,
  }) {
    print('hello');

    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(SocialRegisterSuccessState());
      userCreate(
        uid: value.user!.uid,
        userName: userName,
        email: email,
        DateofBirth: DateofBirth,
        gender: gender,
        address: address,
        token: token,
      );
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String uid,
    required String userName,
    required String email,
    required String DateofBirth,
    required String gender,
    required String address,
    required String token,
  }) {
    UserModel? model = UserModel(
        userName: userName,
        email: email,
        uid: uid,
        token: token,
        bio: 'write your bio ...',
        DateofBirth: DateofBirth,
        gender: gender,
        address: address,
        isEmailVerified: false,
        coverImage:
            'https://i.pinimg.com/originals/30/5c/5a/305c5a457807ba421ed67495c93198d3.jpg',
        profileImage:
            'https://isobarscience.com/wp-content/uploads/2020/09/default-profile-picture1.jpg'
        // name: userName,
        // email: email,
        //
        // uId: uId,
        // bio: 'write you bio ...',
        // cover:
        //     'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
        // image:
        //     'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
        // isEmailVerified: false,
        );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap()!)
        .then((value) {
      emit(SocialCreateUserSuccessState(uid));
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassword = true;
  bool isPasswordCN = true;
  var selectedGender;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;

    emit(SocialRegisterChangePasswordVisibilityState());
  }

  void changePasswordCNVisibility() {
    isPasswordCN = !isPasswordCN;
    suffix = isPasswordCN ? Icons.visibility : Icons.visibility_off;

    emit(SocialRegisterChangePasswordVisibilityState());
  }

  changeRadioValue(sg) {
    selectedGender = sg;
    emit(SocialRegisterRadiobuttonValueState());
  }
}
