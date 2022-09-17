import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'data.dart';

class Urgence extends StatefulWidget {
  const Urgence({Key? key}) : super(key: key);

  @override
  State<Urgence> createState() => _UrgenceState();
}

class _UrgenceState extends State<Urgence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Urgence"),
      ),
      body:  const MesUrgence(),
    );
  }
}
class MesUrgence extends StatefulWidget {
  const MesUrgence({Key? key}) : super(key: key);

  _callNumber() async{
    const number = '08592119XXXX'; //set the number here
    bool res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  State<MesUrgence> createState() => _MesUrgenceState();
}

class _MesUrgenceState extends State<MesUrgence> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: data.map((item) {
        return Card(
          child: ListTile(
            onTap: () => _callNumber (item['url']),
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: FaIcon(
                item['icon'],
                color: item['color'],
                size: 25,
              ),
            ),
            title: Text(
              item['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Text(item['url']),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => _callNumber(item['url']),
            ),
          ),
        );
      }).toList(),
    );
  }
}
