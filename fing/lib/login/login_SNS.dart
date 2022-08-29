// ignore_for_file: deprecated_member_use
import 'package:fing/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:auth_buttons/auth_buttons.dart';
import 'package:auth_buttons/auth_buttons.dart'
    show GoogleAuthButton, AuthButtonStyle, AuthButtonType, AuthIconType;

import '../firebase_auth_remote_data_source.dart';

class Login_SNS extends StatelessWidget {
  const Login_SNS({Key? key}) : super(key: key);

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _kakao_user_info() async {
    try {
      kakao.User user = await kakao.UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  Future kakao_login() async {
    kakao.User? user;
    user = await kakao.UserApi.instance.me();
    final _firebaseAuthDataSource = FirebaseAuthRemoteDataSource();
    final token = await _firebaseAuthDataSource.createCustomToken({
      'uid': user.id.toString(),
      'displayName': user.kakaoAccount!.profile!.nickname,
      'email': user.kakaoAccount!.email!,
      'photoURL': user.kakaoAccount!.profile!.profileImageUrl,
    });

    await FirebaseAuth.instance.signInWithCustomToken(token);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 170.0, 50.0, 0.0),
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
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
            // Image.asset("assets/images/kakao_login.png"),
            SizedBox(
              height: 80.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Root()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: Size.fromHeight(50), // 높이만 50으로 설정
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('images/glogo.png'),
                      Text(
                        '구글로 로그인',
                        style: TextStyle(color: Colors.black87, fontSize: 15.0),
                      ),
                      Opacity(
                        opacity: 0.0,
                        child: Image.asset('images/glogo.png'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                ElevatedButton(
                  onPressed: () async {
                  kakao.KakaoSdk.init(
                      nativeAppKey: 'a3feadb74b79c4040c956d3c0e962c1f');
                  kakao.User user = await kakao.UserApi.instance.me();
                  final _firebaseAuthDataSource =
                      FirebaseAuthRemoteDataSource();
                  if (await kakao.isKakaoTalkInstalled()) {
                    try {
                      await kakao.UserApi.instance.loginWithKakaoTalk();
                      print('카카오톡으로 로그인 성공');
                      print('회원번호: ${user.id}'
                          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
                      Navigator.push(
                          //화면전환
                          context,
                          MaterialPageRoute(builder: (context) => Root()));

                      final token =
                          await _firebaseAuthDataSource.createCustomToken({
                        'uid': user.id.toString(),
                        'displayName':
                            user.kakaoAccount?.profile?.nickname.toString(),
                        'email': user.kakaoAccount?.email.toString(),
                        'photoURL': user.kakaoAccount?.profile?.profileImageUrl
                            .toString(),
                      });

                      await FirebaseAuth.instance.signInWithCustomToken(token);
                    } catch (error) {
                      print('카카오톡으로 로그인 실패 $error');

                      try {
                        await kakao.UserApi.instance.loginWithKakaoTalk();
                        print('카카오톡으로 로그인 성공');
                        print('회원번호: ${user.id}'
                            '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
                        Navigator.push(
                            //화면전환
                            context,
                            MaterialPageRoute(builder: (context) => Root()));

                        final token =
                            await _firebaseAuthDataSource.createCustomToken({
                          'uid': user.id.toString(),
                          'displayName':
                              user.kakaoAccount?.profile?.nickname.toString(),
                          'email': user.kakaoAccount?.email.toString(),
                          'photoURL': user
                              .kakaoAccount?.profile?.profileImageUrl
                              .toString(),
                        });

                        await FirebaseAuth.instance
                            .signInWithCustomToken(token);
                      } catch (error) {
                        print("카카오 계정으로 로그인 실패");
                      }
                    }
                  } else {
                    try {
                      await kakao.UserApi.instance.loginWithKakaoTalk();
                      print('카카오톡으로 로그인 성공');
                      print('회원번호: ${user.id}'
                          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
                      Navigator.push(
                          //화면전환
                          context,
                          MaterialPageRoute(builder: (context) => Root()));
                      final token =
                          await _firebaseAuthDataSource.createCustomToken({
                        'uid': user.id.toString(),
                        'displayName':
                            user.kakaoAccount?.profile?.nickname.toString(),
                        'email': user.kakaoAccount?.email.toString(),
                        'photoURL': user.kakaoAccount?.profile?.profileImageUrl
                            .toString()
                      });
 
                      await FirebaseAuth.instance.signInWithCustomToken(token);
                    } catch (error) {
                      print("카카오 계정으로 로그인 실패 $error ");
                    }
                  }
                },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffFEE500),
                    minimumSize: Size.fromHeight(50), // 높이만 50으로 설정
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('images/kakao4.png'),
                      Text(
                        '카카오 로그인',
                        style: TextStyle(color: Colors.black87, fontSize: 15.0),
                      ),
                      Opacity(
                        opacity: 0.0,
                        child: Image.asset('images/kakao4.png'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
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

            // FlatButton(
            //   color: Colors.grey.withOpacity(0.3),
            //   // onPressed: signInWithGoogle, //어 나중에... 헤헤 ... 허허 .. 진짜 로그인하기!!><
            //   onPressed: () {
            //     Navigator.push(
            //         //화면전환
            //         context,
            //         MaterialPageRoute(builder: (context) => Root()));
            //   },
            //   child: Text("Google Login"),
            // ),

          ]),
        ),
      ),
    );
  }
}
