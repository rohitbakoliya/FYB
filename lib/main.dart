import 'package:auth/screens/auth/forgot.dart';
import 'package:auth/screens/auth/signIn.dart';
import 'package:auth/screens/auth/signUp.dart';
import 'package:auth/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:auth/screens/auth/root.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner : false,
        initialRoute: '/r',
        routes: {
          '/r':(context)=>Root(),
          '/' : (context)=>SignIn(),
          '/signup' : (context)=> SignUp(),
          '/forgotPassword' :(context)=> ForgotPassword(),
          '/home' : (context)=> Home(),
        },
      title: 'My app',
    );
  }
}
