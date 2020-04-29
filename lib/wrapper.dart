import 'package:auth/screens/auth/signIn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:auth/screens/home/home.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final FirebaseUser user  = Provider.of<FirebaseUser>(context);
    print('user is $user');
    if(user!=null)
      return Home(user: user,);
    else
     return SignIn(); 
  }
}
