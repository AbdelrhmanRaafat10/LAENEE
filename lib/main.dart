import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:la2enee_app1/Module/home/cubit/states.dart';
import 'package:la2enee_app1/Module/home/main_page.dart';
import 'package:la2enee_app1/Module/login/login_page.dart';
import 'package:la2enee_app1/components/network/local/cache_helper.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart' show Phoenix;
import 'Module/home/cubit/cubit.dart';
import 'Module/home/home.dart';
import 'components/bloc_observer.dart';
import 'components/components.dart';
import 'components/constants.dart';
import 'components/cubit/cubit.dart';
import 'components/cubit/states.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;

  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //   apiKey: "AIzaSyC9WmmKQvVn-__WAieVgKoLSRF39f57jMQ",
      //   appId: "XXX",
      //   messagingSenderId: "XXX",
      //   projectId: "XXX",
      // ),
      );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  uid = CacheHelper.getData(key: 'uid');

  if (uid != null) {
    widget = MyHomePage();
    //   MyHomePage();
  } else {
    widget = Login();
  }
  runApp(Phoenix(
    child: LA2ENEE(
      startWidget: widget,
    ),
  ));
}
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  // 'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class LA2ENEE extends StatelessWidget {
  //const LA2ENEE({Key? key}) : super(key: key);
  // This widget is the root of your application.
  final bool? isDark;
  final Widget? startWidget;

  LA2ENEE({
    this.startWidget,
    this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit(SocialInitialState())
              // ..getUserData()
              ..getFinderPosts()
              ..getSeekerPosts()
              //..getPosts()
              ..getUserPosts(uid)
            // ..getUsers()
            //..getUserseekerPosts(uid)
            ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
