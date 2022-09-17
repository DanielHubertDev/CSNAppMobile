import 'package:csnapp/a_propos.dart';
import 'package:csnapp/carnet.dart';
import 'package:csnapp/chat.dart';
import 'package:csnapp/connect.dart';
import 'package:csnapp/ordonnance.dart';
import 'package:csnapp/profil.dart';
import 'package:csnapp/qr_code.dart';
import 'package:csnapp/rdv.dart';
import 'package:csnapp/docurge/urgence.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CSN App MENU"),
    backgroundColor: Colors.green,
    actions: [

    PopupMenuButton(
    // add icon, by default "3 dot" icon
    //icon: Icon(Icons.menu)
    itemBuilder: (context){
    return [
    PopupMenuItem<int>(
    value: 0,
      child: Container(decoration: BoxDecoration(),
        child: Row(
          children: [
            Icon(Icons.question_answer,size: 15,color: Colors.black,),
            Text("  A propos",style: TextStyle(color: Colors.black,fontSize: 15),)
          ],),
      ),
    ),

    PopupMenuItem<int>(
    value: 1,
      child: Container(decoration: BoxDecoration(),
        child: Row(
          children: [
            Icon(Icons.qr_code,size: 15,color: Colors.black,),
            Text("  QR-Code",style: TextStyle(color: Colors.black,fontSize: 15),)
          ],),
      ),
    ),

    PopupMenuItem<int>(
    value: 2,
      child: Container(decoration: BoxDecoration(),
        child: Row(
          children: [
            Icon(Icons.logout,size: 15,color: Colors.black,),
            Text("  Déconnexion",style: TextStyle(color: Colors.black,fontSize: 15),)
          ],),
      ),
    ),
    ];
    },
    onSelected:(value){
    if(value == 0){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Apropos()));
    }else if(value == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>QrCode()));
    }else if(value == 2){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AlertDialog(
        title: const Text("Déconnection"),
        content: const Text("Voullez-vous, vous déconnecter?"),
        actions: [
          ElevatedButton(
              onPressed: () async{
                Navigator.of(context).pop();
      },
              child: const Text("NON")),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Connect()));
            },
            child: const Text("OUI"))

        ],
      )));
    }
    }
    ),

    ],
    ),

      body: Container(
        child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: GridView(
          children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Carnet()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.purple,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book,size: 80,color: Colors.white,),
                  Text("Carnet",style: TextStyle(color: Colors.white,fontSize: 18),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  Profil()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.orange,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_history,size: 80,color: Colors.white,),
                  Text("Profil",style: TextStyle(color: Colors.white,fontSize: 18),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Ordonnance()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.red,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.medical_services,size: 80,color: Colors.white,),
                  Text("Ordonnance",style: TextStyle(color: Colors.white,fontSize: 15),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Chat()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.blue,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wechat,size: 80,color: Colors.white,),
                  Text("Contact",style: TextStyle(color: Colors.white,fontSize: 18),)
                ],),
            ),
          ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Rdv()));
              },
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.blueGrey,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment,size: 80,color: Colors.white,),
                    Text("Rendez vous",style: TextStyle(color: Colors.white,fontSize: 15),)
                  ],),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Urgence()));
              },
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.pinkAccent,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_ic_call,size: 80,color: Colors.white,),
                    Text("Urgence",style: TextStyle(color: Colors.white,fontSize: 18),)
                  ],),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Ordonnance()));
              },
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.brown,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.medical_services,size: 80,color: Colors.white,),
                    Text("Ordonnance",style: TextStyle(color: Colors.white,fontSize: 18),)
                  ],),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Chat()));
              },
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.grey,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wechat,size: 80,color: Colors.white,),
                    Text("Chat",style: TextStyle(color: Colors.white,fontSize: 15),)
                  ],),
              ),
            ),
        ],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
        ),
      ),
      ),
    );
  }
}
