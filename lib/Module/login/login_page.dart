import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:la2enee_app1/Module/home/main_page.dart';
import 'package:la2enee_app1/Module/login/cubit/cubit.dart';
import 'package:la2enee_app1/Module/login/cubit/states.dart';
import 'package:la2enee_app1/components/my_flutter_app_icons.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la2enee_app1/components/components.dart';
import 'package:la2enee_app1/components/network/local/cache_helper.dart';
import '../../components/constants.dart';
import '../../components/my_flutter_app_icons.dart';
//mport '../../firebase/Fire_Auth.dart';
import 'package:la2enee_app1/Module/home/home.dart';
import 'package:la2enee_app1/Module/sign%20up/signup_page.dart';

import '../home/cubit/cubit.dart';
import '../home/cubit/states.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Login extends StatelessWidget {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    navigateToSignUp() async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUp()));
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => SocialLoginCubit()),
        BlocProvider(
            create: (BuildContext context) =>
                SocialCubit(SocialInitialState())..getUserData()),
      ],
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if (state is SocialLoginSuccessState) {
            print(SocialLoginCubit.get(context).getdata);
            SocialLoginCubit.get(context).getdata = true;
            CacheHelper.saveData(
              key: 'uid',
              value: state.uid,
            ).then((value) {
              uid = state.uid;
              print(SocialLoginCubit.get(context).getdata);
              navigateAndFinish(
                context,
                MyHomePage(),
              );
              emailController.clear();
              passwordController.clear();
            });
          }
        },
        builder: (context, state) {
          //SocialCubit.get(context).getUserData();
          return Scaffold(
              //appBar: AppBar(),
              body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(45.0),
              child: Container(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ignore: prefer_const_constructors
                      SizedBox(height: 40),
                      // ignore: prefer_const_constructors
                      Text(
                        "Welcome Back",
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          // ignore: prefer_const_constructors
                          color: Color(0xFF125BE4),
                        ),
                      ),

                      Container(
                        height: 250,
                        child: Padding(
                          padding: const EdgeInsets.all(45.0),
                          child: Image(
                            image: AssetImage("images/LOGO.png"),
                            //fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'email must not be empty';
                          }
                          return null;
                        },
                        label: 'Email',
                        prefix: Icon(
                          Icons.email,
                          color: Color(0xFF125BE4),
                        ),
                      ),

                      // ignore: prefer_const_constructors
                      SizedBox(height: 20),

                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'password',
                        prefix: Icon(MyFlutterApp.security_shield,
                            color: Color(0xFF125BE4)),
                        suffix: SocialLoginCubit.get(context).suffix,
                        isPassword: SocialLoginCubit.get(context).isPassword,
                        suffixPressed: () {
                          SocialLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'password must not be empty';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 160),
                        child:
                            // ignore: prefer_const_constructors
                            TextButton(
                          onPressed: () {
                            print(uid);
                          },
                          child: Text(
                            'Forget your Password ?',
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                                //  fontWeight: FontWeight.bold,
                                //color: Color(0xFF125BE4),
                                ),
                          ),
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(height: 20),

                      ConditionalBuilder(
                        condition: state is! SocialLoginLoadingState,
                        builder: (context) => MaterialButton(
                          padding: EdgeInsets.fromLTRB(120, 15, 120, 15),

                          onPressed: () async {
                            var fcm =
                                await FirebaseMessaging.instance.getToken();
                            if (formkey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                              //
                              // SocialCubit.get(context).getUserData();
                              // User? user =
                              //     await FireAuth.signInUsingEmailPassword(
                              //         email: emailController.text,
                              //         password: passwordController.text,
                              //         context: context);
                              // if (user != null) {
                              //   Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => MyHomePage(
                              //               user: user,
                              //             )),
                              //     (Route<dynamic> route) => false,
                              //   );
                              // }\\
                              //SocialCubit.get(context).getUserData();
                              print("3aaaaaaaaaaaaaaaa");
                              print(uid);
                            }
                          },

                          // ignore: prefer_const_constructors
                          child: Text(
                            'LOGIN',
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          // ignore: prefer_const_constructors
                          color: Color(0xFF125BE4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('DON\'HAVE ANY ACCOUNT? '),
                          GestureDetector(
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF125BE4),
                              ),
                            ),
                            onTap: navigateToSignUp,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
