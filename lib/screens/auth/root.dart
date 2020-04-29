import 'package:auth/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {

  Stream<FirebaseUser> get user{
    return FirebaseAuth.instance.onAuthStateChanged;
  }
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: user,
      child: Wrapper(),
    );
  }
  // bool isLogin = false;
  // FirebaseUser _user;
  // @override
  // void initState() {
  //   super.initState();
  //   currentUser().then((user) =>{
  //     setState(
  //       (){
  //         isLogin = user.uid==null  ? false : true;
  //         _user = user;
  //       }
  //     )
  //   } );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   print('here loginis $isLogin');
  //   return isLogin ? Home(user: _user) : SignIn();
  // }
  // Future< FirebaseUser > currentUser() async{
  //   FirebaseUser user =  await FirebaseAuth.instance.currentUser();
  //   return user;
  // }

}
