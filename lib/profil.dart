import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  CollectionReference users = FirebaseFirestore.instance.collection('UserMobile');
  late final uid;
  final user = FirebaseAuth.instance.currentUser;
  final nomController=new TextEditingController();
  final prenomController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (user != null){
      uid = user!.uid;
    }
    print(uid);
    return Scaffold(
        appBar: AppBar(
        title: Text('Profil'),
    ),
        body:FutureBuilder<DocumentSnapshot>(
    future: users.doc(uid).get(),
    builder:
    (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    if (snapshot.hasError) {
    return Text("Something went wrong");
    }

    if (snapshot.hasData && !snapshot.data!.exists) {
    return Text("Document does not exist");
    }

    if (snapshot.connectionState == ConnectionState.done) {
    Map<String, dynamic> data =
    snapshot.data!.data() as Map<String, dynamic>;
    String photo=data['Image'];
    return Center(
    child: SingleChildScrollView(
    child: Container(
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
    child: Column(children: <Widget>[
    Container(
    width: 240,
    height: 240,
    child: Center(
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Image.network(photo,),
    ],
    ),
    ),
    decoration: BoxDecoration(
    border: Border.all(color:Colors.black),
    borderRadius: BorderRadius.circular(100)
    ),
    ),
    SizedBox(height: 15,),
    TextFormField(
    autofocus: false,
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.account_circle),
    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    hintText: 'Nom: ${data['Nom']}',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10))),
    ),
    SizedBox(height: 15,),
    TextFormField(
    autofocus: false,
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.account_circle),
    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    hintText: 'Prenom: ${data['Prenom']}',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10))),
    ),
    SizedBox(height: 15,),
    TextFormField(
    autofocus: false,
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.account_circle),
    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    hintText: 'Email: ${data['Email']}',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10))),
    ),
    SizedBox(height: 15,),
    Text("*****Modifier les données d'utilisateur*****",style: TextStyle(fontSize: 16),),
    SizedBox(height: 15,),
    TextFormField(
    autofocus: false,
    controller: nomController,
    textInputAction: TextInputAction.next,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Veuillez remplir les champs';
    }
    return null;
    },
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.account_circle),
    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    hintText: "Nom",
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10))),
    ),
    SizedBox(height: 15,),
    TextFormField(
    autofocus: false,
    controller: prenomController,
    textInputAction: TextInputAction.next,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Veuillez remplir les champs';
    }
    return null;
    },
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.account_circle),
    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    hintText: "Prenom",
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10))),
    ),
    SizedBox(height: 15,),
    Row(

    children:<Widget> [
    ElevatedButton(onPressed: () {
    final docUser = FirebaseFirestore.instance
        .collection('UserMobile')
        .doc(uid);
    docUser.update({
    'Nom': nomController.text,
    'Prenom': prenomController.text,
    });
    Navigator.push(context,MaterialPageRoute(builder: (context) => Profil()));
    }, child:Text("Modifier") ,

    ),
    SizedBox(width: 140,),
    ElevatedButton(
    onPressed: () async {
    final docUser = FirebaseFirestore.instance
        .collection('UserMobile')
        .doc(uid);
    docUser.update({
    'Nom': FieldValue.delete(),
    'Prenom': FieldValue.delete(),
    });
    Navigator.push(context,MaterialPageRoute(builder: (context) => Profil()));
    },
    child: Text(
    'Supprimer',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    ),
    ],
    ),

    ]),
    ),
    ),
    ),
    ),
    );
    }
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.green,
        ),
      ),
    );
    },
    ),
    );
  }
}
