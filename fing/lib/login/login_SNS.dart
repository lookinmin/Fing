// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/Firebase/fing_db.dart';
import 'package:fing/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:auth_buttons/auth_buttons.dart'
    show GoogleAuthButton, AuthButtonStyle, AuthButtonType, AuthIconType;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;

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

  void _get_user_info() async {
    try {
      kakao.User user = await kakao.UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 170.0, 50.0, 0.0),
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Text(
              '페스티벌이 궁금해?',
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
                  'Fing',
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
              height: size.height * 0.2,
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
                    minimumSize: Size.fromHeight(60), // 높이만 50으로 설정
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          child: Image.asset(
                        'assets/images/GoogleLogo.png',
                        width: size.width * 0.07,
                      )),
                      Text(
                        'Google 로그인',
                        style: TextStyle(color: Colors.black87, fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                  final _firebaseAuthDataSource = FirebaseAuthRemoteDataSource();
                  kakao.KakaoSdk.init(nativeAppKey: 'a0f1222696827f5577c696088787bc1f');
                  
                  if (await kakao.isKakaoTalkInstalled()) {
                    try {
                      await kakao.UserApi.instance.loginWithKakaoTalk();
                      print('카카오톡으로 로그인 성공');
                      _get_user_info();
                      kakao.User user = await kakao.UserApi.instance.me();
                         final token = await _firebaseAuthDataSource.createCustomToken(
                         {
                           'uid' : user.id.toString(),
                           'displayName' : user.kakaoAccount?.profile?.nickname.toString(),
                           'email' : user.kakaoAccount?.email.toString(),
                           'photoURL' : user.kakaoAccount?.profile?.profileImageUrl.toString()
                         }
                       );
                         await FirebaseAuth.instance.signInWithCustomToken(token);

                        
                        fing_db_user.add(fing_db(user.kakaoAccount!.profile!.nickname.toString(), user.kakaoAccount!.email.toString()));
                        print("login추가됨됨됨"+fing_db_user.length.toString());
                        
                         //await addinfo().createUser(_fing_db.toJson(),user.kakaoAccount!.email.toString());
                         await FirebaseFirestore.instance.collection('User').doc(user.kakaoAccount!.email.toString()).collection("Privacy").add({
                          "name": user.kakaoAccount?.profile?.nickname.toString(),
                          "email": user.kakaoAccount?.email.toString()
                          }
                         );
                         
                         Navigator.push(
                         //화면전환
                         context,
                         MaterialPageRoute(builder: (context) => Root()));
                    } catch (error) {
                      print('카카오톡으로 로그인 실패 $error');

                      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                      try {
                        await kakao.UserApi.instance.loginWithKakaoAccount();
                        print('카카오계정으로 로그인 성공');
                        _get_user_info();
                        kakao.User user = await kakao.UserApi.instance.me();
                           final token = await _firebaseAuthDataSource.createCustomToken(
                         {
                           'uid' : user.id.toString(),
                           'displayName' : user.kakaoAccount?.profile?.nickname.toString(),
                           'email' : user.kakaoAccount?.email.toString(),
                           'photoURL' : user.kakaoAccount?.profile?.profileImageUrl.toString()
                         }
                       );
                         await FirebaseAuth.instance.signInWithCustomToken(token);

                        
                        //fing_db_user.add(fing_db(name: user.kakaoAccount!.profile!.nickname.toString(), email: user.kakaoAccount!.email.toString()));
                        //fing_db_user.add(user.kakaoAccount!.email.toString());
                         fing_db_user.add(fing_db(user.kakaoAccount!.profile!.nickname.toString(), user.kakaoAccount!.email.toString()));
                        print("login추가됨됨됨"+fing_db_user.length.toString());
                        

                         await FirebaseFirestore.instance.collection('User').doc(user.kakaoAccount!.email.toString()).collection("Privacy").add({
                          "name": user.kakaoAccount?.profile?.nickname.toString(),
                          "email": user.kakaoAccount?.email.toString()
                          }
                         );

                         Navigator.push(
                         //화면전환
                         context,
                         MaterialPageRoute(builder: (context) => Root()));
                      } catch (error) {
                        print('카카오계정으로 로그인 실패 $error');
                      }
                    }
                  } else {
                    try {
                      await kakao.UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공');
                      _get_user_info();
                      kakao.User user = await kakao.UserApi.instance.me();
                         final token = await _firebaseAuthDataSource.createCustomToken(
                         {
                           'uid' : user.id.toString(),
                           'displayName' : user.kakaoAccount?.profile?.nickname.toString(),
                           'email' : user.kakaoAccount?.email.toString(),
                           'photoURL' : user.kakaoAccount?.profile?.profileImageUrl.toString()
                         }
                       );
                        FirebaseFirestore db = FirebaseFirestore.instance;
                        // fing_db.fromMap()
                         //await addinfo().createUser(_fireModel.toJson(),user.kakaoAccount!.email.toString());
                         fing_db_user.add(fing_db(user.kakaoAccount!.profile!.nickname.toString(), user.kakaoAccount!.email.toString()));
                        print("login추가됨됨됨"+fing_db_user.length.toString());
                        
                        await FirebaseFirestore.instance.collection('User').doc(user.kakaoAccount!.email.toString()).collection("Privacy").doc().set({
                          
                          "name": user.kakaoAccount?.profile?.nickname.toString(),
                          "email": user.kakaoAccount?.email.toString()
                          }
                         ,SetOptions(merge: true));

                        //fing_db(name: user.kakaoAccount!.profile!.nickname.toString(), email: user.kakaoAccount!.email.toString());

                         await FirebaseAuth.instance.signInWithCustomToken(token);
                         Navigator.push(
                         //화면전환
                         context,
                         MaterialPageRoute(builder: (context) => Root()));
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  }
                },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffFEE500),
                    minimumSize: Size.fromHeight(60), // 높이만 50으로 설정
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          child: Image.asset(
                        'assets/images/KakaoLogo.png',
                        width: size.width * 0.08,
                      )),
                      Text(
                        'KaKao 로그인',
                        style: TextStyle(color: Colors.black87, fontSize: 16.0),
                      ),
                    ],
                  ),

                ),
                SizedBox(
                  height: 25,
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

class FireModel{
  String? name;
  String? email;

  FireModel({
    this.name,
    this.email,
  });

  Map<String,String> toJson(){
    final map = <String, String>{};
    map['name'] = name!;
    map['email'] = email!;
    return map;
  }
}

// class addinfo {
//   static final addinfo _fireService = addinfo._internal();
//   factory addinfo() => _fireService;
//   addinfo._internal();

//   Future createUser(Map<String, String> json, String collection_name) async {
//     await FirebaseFirestore.instance.collection(collection_name).doc("Privacy").set(data)  }
// }