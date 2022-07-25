import 'package:flutter/material.dart';
import '../MainPage/bottomMain.dart';
import '../main.dart';

void main() => runApp(MaterialApp(
      title: "App",
      home: SplashRoute(),
    ));

class SplashRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Move Main route'),
          onPressed: () {
            // 눌렀을 때 두 번째 route로 이동합니다.
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
        ),
      ),
    );
  }
}
