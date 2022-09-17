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

class sign_in extends StatelessWidget {
  const sign_in({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var mobileWidth = 700;
    bool isWeb = true;
    size.width > mobileWidth ? isWeb = true : isWeb = false;

    final _firebaseAuth = FirebaseAuth.instance;
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _nicknameController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            width: isWeb ? (size.width * 0.65) : (size.width * 0.9),
            padding: isWeb
                ? EdgeInsets.fromLTRB(80.0, 100.0, 80.0, 100.0)
                : EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
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
                height: 4.0,
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
                height: 15.0,
              ),
              Text(
                "Fing의 회원이 되어, 다양한 페스티벌을 즐겨보세요!",
                style: TextStyle(
                  letterSpacing: 0.0,
                  fontSize: 15.0,
                  color: Color.fromARGB(255, 70, 70, 70),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  TextFormField(
                    controller: _nicknameController,
                    decoration: const InputDecoration(labelText: 'Nickname'),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);
                        fing_db_user.add(fing_db(_nicknameController.text,
                            _emailController.text, "google"));
                        print("login추가됨됨됨" + fing_db_user.length.toString());

                        FirebaseFirestore.instance
                            .collection('User')
                            .doc(_emailController.text)
                            .collection("Privacy")
                            .doc("Main")
                            .set({
                          "name": _nicknameController.text,
                          "email": _emailController.text
                        }).then((value) {
                          Navigator.pop(context);

                          return value;
                        });
                        FirebaseAuth.instance.currentUser
                            ?.sendEmailVerification();
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: Text("더 복잡한 비밀번호를 입력해주세요"));
                              });
                          // print('the password provided is too weak');
                        } else if (e.code == 'email-already-in-use') {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: Text("이미 존재하는 이메일 입니다."));
                              });
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: Text("이메일과 비밀번호를 입력해주세요"));
                              });
                        }
                      } catch (e) {
                        print('끝');
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
                          width: size.width * 0.2,
                          child: Text(
                            '회원가입',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
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
            ]),
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