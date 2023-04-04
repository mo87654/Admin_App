
import 'package:admin_app/modules/home%20screen/admin_Home.dart';
import 'package:admin_app/modules/login%20screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

bool isLogin = false;

void main() async{
  // FirebaseApp.initializeApp(/*context=*/ this);
  // FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.getInstance();
  // firebaseAppCheck.installAppCheckProviderFactory(
  //     PlayIntegrityAppCheckProviderFactory.getInstance());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;

  if(user == null){
    isLogin = false ;
  }else{
    isLogin = true ;
  }

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.autoScale(480, name: 'SM'),
          const ResponsiveBreakpoint.autoScale(800, name: 'MD'),
          const ResponsiveBreakpoint.autoScale(1000, name: 'LG'),
          const ResponsiveBreakpoint.autoScale(1200, name: 'XL'),
          const ResponsiveBreakpoint.autoScale(2460, name: '2XL'),
        ],),
      home: isLogin == false? Login(): AdminHome(),
      routes: {

      },

      debugShowCheckedModeBanner: false,
    );
  }
}


