import 'dart:convert';
import 'package:http/http.dart' as http;



class FirebaseAuthRemoteDataSource {
  final String url = 'https://asia-northeast3-fing-firebase-cbnu.cloudfunctions.net/createCustomToken'; //서버 구축시 url


  Future<String> createCustomToken(Map<String, dynamic> user) async {
    final customTokenResponse = await http
          .post(Uri.parse(url), body: user);
    
    return customTokenResponse.body; //body로 토큰을 보냄
  }
}