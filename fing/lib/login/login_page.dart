import 'package:fing/MainPage/mainpage.dart';
import 'package:fing/main.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';


void main() {
  KakaoSdk.init(nativeAppKey: 'a3feadb74b79c4040c956d3c0e962c1f');
  runApp(const Login());
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  
  @override
  State<Login> createState() => _LoginState();

}

class _LoginState extends State<Login> {
  
  @override
  Widget build(BuildContext context) {
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
              height: 80.0,
            ),
            //Image.asset("images/kakao_login.png"),

            SizedBox(
              height: 80.0,
            ),

            Center(
              child: Text(
                '가입 문구',
                style: TextStyle(
                  letterSpacing: 0.0,
                  fontSize: 10.0,
                  color: Colors.black,
                ),
              ),
            ),
            
            RaisedButton(
              onPressed: () async {
                
                  KakaoSdk.init(nativeAppKey: 'a3feadb74b79c4040c956d3c0e962c1f');
                  User user = await UserApi.instance.me();
                  if (await isKakaoTalkInstalled()) {
                    try {
                      await UserApi.instance.loginWithKakaoTalk();
                      print('카카오톡으로 로그인 성공');
                      print('회원번호: ${user.id}'
                      '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
                      Navigator.push(
                      //화면전환
                      context,
                      MaterialPageRoute(builder: (context) => Root()));

                    } catch (error) {
                      print('카카오톡으로 로그인 실패 $error');
                      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                      try {
                        await UserApi.instance.loginWithKakaoAccount();
                        print('카카오계정으로 로그인 성공');
                        await UserApi.instance.loginWithKakaoTalk();
                        print('카카오톡으로 로그인 성공');
                        print('회원번호: ${user.id}'
                        '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
                      } catch (error) {
                        print('카카오계정으로 로그인 실패 $error');
                      }
                    }
                  } 
                  else{
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공');
                      // await UserApi.instance.loginWithKakaoTalk();
                      // print('카카오톡으로 로그인 성공');
                      print('회원번호: ${user.id}'
                      '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
                      Navigator.push(
                      //화면전환
                      context,
                      MaterialPageRoute(builder: (context) => Root()));
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  }
              }
            )
          ],
        ),
      ),
    );
  }
}
