import 'package:flutter/material.dart';

class MyList extends StatelessWidget {
  final String child;
  MyList({required this.child});

  @override
  Widget build(BuildContext context) {
    final bwidth=MediaQuery.of(context).size.width * 0.1;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:2.0),
      child: Container(
        height: 100,
        color: Colors.deepPurple[100],
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(bwidth, 10, bwidth, 0),             
                  child: Text(child,style: TextStyle(fontSize: 18),)
                  ),
                  Padding(
                  padding: EdgeInsets.fromLTRB(bwidth, 13, 0, 0),             
                  child: Text('150m',style: TextStyle(fontSize: 10),)
                  ),
                  Container(             
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                    maxWidth: MediaQuery.of(context).size.width*0.6
                  ),             
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(bwidth, 1, 0, 0), 
                    child: Text('서울 송파구 올림픽로 300 (신천동) 롯데월드몰 캐주얼동 4층',style: TextStyle(fontSize: 10),),
                  )
                  ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.07,
            ),
            Container(
              constraints: BoxConstraints(
                    maxHeight: 80,
                    maxWidth: 100
                  ),
                  color: Colors.blueGrey,
                  //child: Image.asset('images/Fing1.png',fit: BoxFit.fill,)
            )
          ],
        )
      ),
    );
  }
}