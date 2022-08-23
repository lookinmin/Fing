
import 'package:fing/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Login_main extends StatelessWidget {
  const Login_main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("firebase load fail"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Login();
        }
        return CircularProgressIndicator();
      },
    );
  }

}

