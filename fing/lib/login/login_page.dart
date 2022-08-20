import 'package:fing/MainPage/mainpage.dart';
import 'package:fing/main.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 170.0, 50.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '어디로 갈꺼야?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                letterSpacing: 0.0,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),

            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Text(
                  'FING',
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 35.5,
                    color: const Color(0xffff7e00),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '찍어!',
                  style: TextStyle(
                    letterSpacing: 0.0,
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Text(
                  'Fing(',
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'F',
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 13.0,
                    color: const Color(0xffff7e00),
                  ),
                ),
                Text(
                  'estival ',
                  style: TextStyle(
                    letterSpacing: 0.0,
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '-ing',
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 14.0,
                    color: const Color(0xffff7e00),
                  ),
                ),
                Text(
                  ')에 오신 것을 환영합니다.',
                  style: TextStyle(
                    letterSpacing: 0.0,
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.24,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Root()));
              },
              child: Image.asset('assets/images/kakao_login_large_Kor.png'),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Center(
              child: Text(
                '가입하면 당사의 서비스 약관에 동의하고',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  letterSpacing: 0.0,
                ),
              ),
            ),
            Center(
              child: Text(
                '개인정보 보호정책을(를) 읽어 당사의 데이터 수집,',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  letterSpacing: 0.0,
                ),
              ),
            ),
            Center(
              child: Text(
                '사용, 공유방법을 확인했음을 인정하는 것입니다.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  letterSpacing: 0.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
