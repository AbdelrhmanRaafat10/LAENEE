import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la2enee_app1/Module/home/cubit/cubit.dart';
import 'package:la2enee_app1/Module/login/cubit/states.dart';
import 'package:flutter/material.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  ////
  // UserModel? userModel;
  // void getUserData() {
  //   emit(SocialGetUserLoadingState());
  //
  //   FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
  //     print(value.data);
  //     userModel = UserModel.fromJson(value.data()!);
  //     emit(SocialGetUserSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(SocialGetUserErrorState(error.toString()));
  //   });
  // }
  ////////
  bool getdata = false;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      getdata = true;
      print(value.user!.email);
      print(value.user!.uid);

      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;

    emit(SocialChangePasswordVisibilityState());
  }
}
