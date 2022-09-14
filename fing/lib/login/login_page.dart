import 'package:fing/login/login_SNS.dart';
import 'package:fing/login/login_page.dart';
import 'package:fing/login/login_page_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../Firebase/fing_db.dart';
import '../main.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.userChanges();

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Login_SNS();
          } else {
            final user = FirebaseAuth.instance.currentUser;
            fing_db_user.add(fing_db(
                user?.displayName.toString(), user!.email.toString(), "null"));
            print("login추가됨됨됨" + fing_db_user.length.toString());
            return Root();
          }
        },
      ),
    );
  }
}
