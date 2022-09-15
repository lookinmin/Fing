import 'package:flutter/material.dart';
import 'package:fing/MainPage/TopMain.dart';
import 'package:fing/MainPage/bottomMain.dart';

// class MainTopBottom extends StatelessWidget {
//   const MainTopBottom({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Flexible(flex: 5, fit: FlexFit.loose, child: TopMain()),
//         Flexible(flex: 5, fit: FlexFit.tight, child: BottomMain()),
//       ],
//     );
//   }
// }

class MainTopBottom extends StatefulWidget {
  const MainTopBottom({Key? key}) : super(key: key);

  @override
  State<MainTopBottom> createState() => _MainTopBottom();
}

class _MainTopBottom extends State<MainTopBottom> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var mobileWidth = 500;
  bool isWeb = true;
  size.width > mobileWidth ? isWeb = true : isWeb = false;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              child: TopMain(),
              height: size.height * 0.4,
            ),
            Container(
              child: BottomMain(),
              height: isWeb? size.height * 1:600,
            ),

          ],
        ),
      ),
    );
  }
}
