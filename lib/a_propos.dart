import 'package:flutter/material.dart';

class Apropos extends StatefulWidget {
  const Apropos({Key? key}) : super(key: key);

  @override
  State<Apropos> createState() => _AproposState();
}

class _AproposState extends State<Apropos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Text('A Propos'),
    );
  }
}
