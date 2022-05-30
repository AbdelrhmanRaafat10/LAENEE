import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:la2enee_app1/Module/home/main_page.dart';
import 'package:la2enee_app1/Module/sign%20up/cubit/cubit.dart';
import 'package:la2enee_app1/Module/sign%20up/cubit/states.dart';
//import '../../firebase/Fire_Auth.dart';
import '../../components/constants.dart';
import '../../components/network/local/cache_helper.dart';
import '../login/login_page.dart';
import '../../components/components.dart';
import '../../components/my_flutter_app_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignUp extends StatelessWidget {
  var emailController = TextEditingController();
  var userNameController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var dateController = TextEditingController();
  var passwordController = TextEditingController();
  var addressController = TextEditingController();
  var profileImage;
  DateTime? currentdate;
  var formkey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

//void AddUsers(){
  //  var emailController = TextEditingController();
  //var userNameController = TextEditingController();
  //var confirmPasswordController = TextEditingController();
  //var dateController = TextEditingController();
  //var passwordController = TextEditingController();
  //var homeController = TextEditingController();
  //var selectedGender;
//}

  bool isPassword = true;
  // validater(value) {
  //   if (selectedGender!.isEmpty) {
  //     return 'city must not be empty';
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    _showdatepicker() async {
      var selecteddate = await showDatePicker(
        context: context,
        initialDate: DateTime(2016),
        firstDate: DateTime(1920),
        lastDate: DateTime(2016),
        //currentDate: DateTime.now(),
      );
      // setState(() {
      //   selecteddate != null ? currentdate = selecteddate : null;
      // });
    }

    navigateToLogin() async {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }

    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            CacheHelper.saveData(
              key: 'uid',
              value: state.uid,
            ).then((value) {
              uid = state.uid;
              navigateAndFinish(
                context,
                MyHomePage(),
              );
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF125BE4),
                          ),
                        ),
                        SizedBox(height: 10),
                        defaultFormField(
                          controller: userNameController,
                          type: TextInputType.name,
                          validate: (value) {
                            //userNameController=value;

                            if (value!.isEmpty) {
                              return 'user name must not be empty';
                            }
                            return null;
                          },
                          label: 'User Name',
                          prefix: Icon(
                            Icons.person,
                            color: Color(0xFF125BE4),
                          ),
                        ),
                        SizedBox(height: 10),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            //emailController=value;
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icon(
                            Icons.email,
                            color: Color(0xFF125BE4),
                          ),
                        ),
                        SizedBox(height: 10),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icon(MyFlutterApp.security_shield,
                              color: Color(0xFF125BE4)),
                          suffix: SocialRegisterCubit.get(context).suffix,
                          isPassword:
                          SocialRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: (value) {
                            //passwordController=value;

                            if (value!.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        defaultFormField(
                          controller: confirmPasswordController,
                          type: TextInputType.visiblePassword,
                          label: 'Confirm Password',
                          prefix: Icon(MyFlutterApp.security_shield,
                              color: Color(0xFF125BE4)),
                          //suffix: SocialRegisterCubit.get(context).suffix,
                          isPassword:
                          SocialRegisterCubit.get(context).isPasswordCN,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordCNVisibility();
                          },
                          validate: (value) {
                            confirmPasswordController.text = value;

                            if (value!.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        defaultFormField(
                          controller: dateController,
                          // type: TextInputType.datetime,
                          label: 'Date of Birth',
                          readonly: true,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime(2016),
                              firstDate: DateTime(1920),
                              lastDate: DateTime(2016),
                            ).then((value) {
                              dateController.text =
                                  DateFormat('dd/MM/yyyy').format(value!);
                            });
                            // _showdatepicker().then((value) {
                            //   dateController.text = DateFormat('dd/MM/yyyy')
                            //       .format(value!)
                            //       .toString();
                            // });
                          },
                          prefix: Icon(
                            MyFlutterApp.calendar_12,
                            color: Color(0xFF125BE4),
                          ),

                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Date of birth must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(MyFlutterApp.lgbtq,
                                  color: Color(0xFF125BE4)),
                              SizedBox(width: 10),
                              Text(
                                "gender",
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xFF414144)),
                              ),
                              Radio(
                                value: "male",
                                groupValue: SocialRegisterCubit.get(context)
                                    .selectedGender,
                                onChanged: (value) {
                                  SocialRegisterCubit.get(context)
                                      .changeRadioValue(value);
                                  // setState(() {
                                  //   selectedGender = value;
                                  // });
                                },
                                activeColor: Color(0xFF125BE4),
                                fillColor: MaterialStateProperty.all(
                                    Color(0xFF125BE4)),
                              ),
                              Text(
                                "male",
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xFF414144)),
                              ),
                              Radio(
                                value: "female",
                                groupValue: SocialRegisterCubit.get(context)
                                    .selectedGender,
                                onChanged: (value) {
                                  SocialRegisterCubit.get(context)
                                      .changeRadioValue(value);
                                  // setState(() {
                                  //   selectedGender = value;
                                  // });
                                },
                                activeColor: Color(0xFF125BE4),
                                fillColor: MaterialStateProperty.all(
                                    Color(0xFF125BE4)),
                              ),
                              Text(
                                "female",
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xFF414144)),
                              ),
                            ],
                          ),
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFF3F3F3),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        SizedBox(height: 10),
                        defaultFormField(
                          controller: addressController,
                          type: TextInputType.name,
                          label: 'city',
                          prefix: Icon(
                            MyFlutterApp.home_address,
                            color: Color(0xFF125BE4),
                          ),
                          validate: (value) {
                            // homeController=value;

                            if (value!.isEmpty) {
                              return 'city must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => MaterialButton(
                            padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                            onPressed: () async {
                              ///////////////////////////////////////////////////////////////////////////////////////////////
                              var fcm =
                              await FirebaseMessaging.instance.getToken();
                              print(fcm);

                              //////////////////////////////////////////////////////////////////////////////////////////////
                              //if (formkey.currentState!.validate()) {
                              // _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                              if (formkey.currentState!.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                    userName: userNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    token: fcm.toString(),
                                    DateofBirth: dateController.text,
                                    gender: SocialRegisterCubit.get(context)
                                        .selectedGender,
                                    address: addressController.text);
                                // User? user =
                                //     await FireAuth.registerUsingEmailPassword(
                                //   userName: userNameController.text,
                                //   email: emailController.text,
                                //   password: passwordController.text,
                                //   uid: '',
                                //   profileImage: profileImage,
                                //   gender: SocialRegisterCubit.get(context)
                                //       .selectedGender,
                                //   birthDate: dateController.text,
                                //   context: context,
                                //   city: homeController.text,
                                // );

                                /*   setState(() {
                              _isProcessing = false;
                            });*/

                                // if (user != null) {
                                //   Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Login()),
                                //     (Route<dynamic> route) => false,
                                //   );
                                // }

                                validate:
                                    (value) {
                                  if (SocialRegisterCubit.get(context)
                                      .selectedGender!
                                      .isEmpty) {
                                    return 'gender must not be empty';
                                  }
                                  return null;
                                };
                                print(userNameController.text);
                                print(emailController.text);
                                print(passwordController.text);
                                print(confirmPasswordController.text);
                                print(dateController.text);
                                print(SocialRegisterCubit.get(context)
                                    .selectedGender
                                    .toString());
                                print(addressController.text);
                              }
                            },
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            color: Color(0xFF125BE4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ALREADY HAVE AN ACCOUNT? '),
                            GestureDetector(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF125BE4),
                                ),
                              ),
                              onTap: navigateToLogin,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}