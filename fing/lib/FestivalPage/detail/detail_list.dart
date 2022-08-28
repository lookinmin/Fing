import 'package:flutter/material.dart';

class MyList extends StatelessWidget {
  final String child;
  MyList({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:2.0),
      child: Container(
        height: 100,
        color: Colors.deepPurple[100],
        child: Center(child: Text(child,style: TextStyle(fontSize: 20),))
      ),
    );
  }
}