import 'package:flutter/cupertino.dart';

class AppNameCustomTextstyle extends StatelessWidget {
  const AppNameCustomTextstyle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'ReadMe',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 32,
        letterSpacing: 2,
      ),
    );
  }
}
