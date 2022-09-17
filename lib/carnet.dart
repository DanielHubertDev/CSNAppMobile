import 'package:flutter/material.dart';

class Carnet extends StatefulWidget {
  const Carnet({Key? key}) : super(key: key);

  @override
  State<Carnet> createState() => _CarnetState();
}

class _CarnetState extends State<Carnet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Text('Carnet'),
    );
  }
}
