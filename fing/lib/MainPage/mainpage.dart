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
    return Column(
      children: [
        Flexible(flex: 5, fit: FlexFit.loose, child: TopMain()),
        Flexible(flex: 5, fit: FlexFit.tight, child: BottomMain()),
      ],
    );
  }
}