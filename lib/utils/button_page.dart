import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  MyButtons({super.key,required this.onPressed, required this.text});
  final String text;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: onPressed, child: Text(text), color: Theme.of(context).primaryColor,);
  }
}
