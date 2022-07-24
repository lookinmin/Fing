import 'package:flutter/material.dart';
import 'package:fing/login/login_page.dart';


class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState(){
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffff7e00),
      
      body: Center(        
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Fing',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
              letterSpacing: 2.0,     
              fontWeight: FontWeight.bold,        
            ),
            ),
            Padding(
               padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              ),
            Text('어디로 갈거야? Fing 찍어~',
            style: TextStyle(
              letterSpacing: 1.0,
              color: Colors.white,

            ),
            )
          ],
        ),
        ),

    );
    
  }

}

