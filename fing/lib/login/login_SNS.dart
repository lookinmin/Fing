// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/Firebase/fing_db.dart';
import 'package:fing/login/sign_in.dart';
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var mobileWidth = 700;
    bool isWeb = true;
    size.width > mobileWidth ? isWeb = true : isWeb = false;

    Future<UserCredential> signInWithGoogle() async {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      fing_db_user.add(fing_db(googleUser?.displayName.toString(),
          googleUser!.email.toString(), "google"));
      print("login추가됨됨됨" + fing_db_user.length.toString());
      print(googleUser!.email.toString());

      await FirebaseFirestore.instance
          .collection('User')
          .doc(googleUser!.email.toString())
          .collection("Privacy")
          .doc("Main")
          .set({
        "name": googleUser?.displayName.toString(),
        "email": googleUser!.email.toString()
      });

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    final _firebaseAuth = FirebaseAuth.instance;
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: isWeb ? (size.width * 0.65) : (size.width * 0.9),
            padding: isWeb
                ? EdgeInsets.fromLTRB(80.0, 100.0, 80.0, 100.0)
                : EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
            child: Center(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                    Text(
                      '페스티벌이 궁금해?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        letterSpacing: 0.0,
                      ),
                    ),
                    SizedBox(
                      height: 0.0,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Text(
                          'Fing',
                          style: TextStyle(
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
                      // height: 15.0,
                      height: size.height * 0.04,
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                        child: Text(
                          "Fing(Festival-ing)에 오신 것을 환영합니다.",
                          style: TextStyle(
                            letterSpacing: 0.0,
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 70, 70, 70),
                          ),
                        )
                        // child: Expanded(
                        //   child: Row(
                        //     // mainAxisSize: MainAxisSize.max,
                        //     // ignore: prefer_const_literals_to_create_immutables
                        //     children: <Widget>[
                        //       Text(
                        //         'Fing(',
                        //         style: TextStyle(
                        //           letterSpacing: 1.0,
                        //           fontSize: 15.0,
                        //           color: Colors.black,
                        //         ),
                        //       ),
                        //       Text(
                        //         'F',
                        //         style: TextStyle(
                        //           letterSpacing: 1.0,
                        //           fontSize: 13.0,
                        //           color: const Color(0xffff7e00),
                        //         ),
                        //       ),
                        //       Text(
                        //         'estival ',
                        //         style: TextStyle(
                        //           letterSpacing: 0.0,
                        //           fontSize: 14.0,
                        //           color: Colors.black,
                        //         ),
                        //       ),
                        //       Text(
                        //         '-ing',
                        //         style: TextStyle(
                        //           letterSpacing: 1.0,
                        //           fontSize: 14.0,
                        //           color: const Color(0xffff7e00),
                        //         ),
                        //       ),
                        //       Text(
                        //         ')에 오신 것을 환영합니다.',
                        //         style: TextStyle(
                        //           letterSpacing: 0.0,
                        //           fontSize: 14.0,
                        //           color: Colors.black,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            signInWithGoogle();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            minimumSize: Size.fromHeight(50), // 높이만 55로 설정
                            // elevation: 1.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.5)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  child: Image.asset(
                                'assets/images/GoogleLogo.png',
                                width: size.width * 0.07,
                              )),
                              Container(
                                width: size.width * 0.4,
                                child: Text(
                                  'Google 로그인',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController
                                          .text) //아이디와 비밀번호로 로그인 시도
                                  .then((value) {
                                print(value);
                                value.user!.emailVerified == true //이메일 인증 여부
                                    ? print("로그인 성공")
                                    : print('이메일 확인 불가');
                                fing_db_user.add(fing_db("fingcbnu",
                                    _emailController.text, "google"));
                                print("login추가됨됨됨" +
                                    fing_db_user.length.toString());

                                FirebaseFirestore.instance
                                    .collection('User')
                                    .doc(_emailController.text)
                                    .collection("Privacy")
                                    .doc("Main")
                                    .set({
                                  "name": "fingcbnu",
                                  "email": _emailController.text
                                });
                                return value;
                              });
                            } on FirebaseAuthException catch (e) {
                              //로그인 예외처리
                              if (e.code == 'user-not-found') {
                                print('등록되지 않은 이메일입니다');
                              } else if (e.code == 'wrong-password') {
                                print('비밀번호가 틀렸습니다');
                              } else {
                                print(e.code);
                              }
                            }

                            // Navigator.push(
                            //     //화면전환
                            //     context,
                            //     MaterialPageRoute(builder: (context) => Root()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(255, 126, 0, 1.0),
                            minimumSize: Size.fromHeight(50), // 높이만 55로 설정
                            // elevation: 1.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.5)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: size.width * 0.4,
                                child: Text(
                                  '로그인',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: size.width * 0.5,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    //화면전환
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => sign_in()));
                              },
                              child: Text("회원가입"),
                              style:
                                  TextButton.styleFrom(primary: Colors.grey)),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '가입하면 당사의 서비스 약관에 동의하고',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                letterSpacing: 0.0,
                              ),
                            ),
                            Text(
                              '개인정보 보호정책을(를) 읽어 당사의 데이터 수집,',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                letterSpacing: 0.0,
                              ),
                            ),
                            Text(
                              '사용, 공유방법을 확인했음을 인정하는 것입니다.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                letterSpacing: 0.0,
                              ),
                            ),
                          ],
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
        ),
      ),
    );
  }
}

class FireModel {
  String? name;
  String? email;
  DocumentReference? reference;

  FireModel(
    this.name,
    this.email,
    this.reference,
  );

  Map<String, String> toJson() {
    final map = <String, String>{};
    map['name'] = name!;
    map['email'] = email!;
    return map;
  }

  FireModel.fromJson(dynamic json, this.reference) {
    name = json['name'];
    email = json['email'];
  }

  FireModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);
}

 

// class addinfo {
//   static final addinfo _fireService = addinfo._internal();
//   factory addinfo() => _fireService;
//   addinfo._internal();

//   Future createUser(Map<String, String> json, String collection_name) async {
//     await FirebaseFirestore.instance.collection(collection_name).doc("Privacy").set(data)  }
// }