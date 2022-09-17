import 'dart:io';
import 'package:csnapp/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';


class Inscrit extends StatefulWidget {
  const Inscrit({Key? key}) : super(key: key);

  @override
  State<Inscrit> createState() => _InscritState();
}

class _InscritState extends State<Inscrit> {
  final auth = FirebaseAuth.instance;
  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final snackBar = SnackBar(
    content: const Text('Bienvenue cher utilisateur'),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
      },
    ),
  );
  final snackBar1 = SnackBar(
    content: const Text('Mots de passe faible'),
    action: SnackBarAction(
      label: 'Re-essayez',
      onPressed: () {
      },
    ),
  );

  final snackBar2 = SnackBar(
    content: const Text('Cet Email existe deja'),
    action: SnackBarAction(
      label: 'Re-essayez',
      onPressed: () {
      },
    ),
  );
  late String url='';
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 100,
                      child: InkWell(
                        child: Icon(Icons.account_circle, size: 150,),
                        onTap: ()async{
                          final _firebaseStorage = FirebaseStorage.instance;
                          final _imagePicker = ImagePicker();
                          PickedFile? image;
                          image = await _imagePicker.getImage(source: ImageSource.gallery);
                          var file = File(image!.path);
                          if (image != null){
//Upload to Firebase
                            var snapshot = await _firebaseStorage.ref()
                                .child('client/'+file.path)
                                .putFile(file);
                            var downloadUrl = await snapshot.ref.getDownloadURL();
                            setState(() {
                              var imageUrl = downloadUrl;
                              url=imageUrl;
                            });
                          } else {
                            print('accune image choisis');
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
                          labelText: "Nom",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
                          labelText: "Prenom",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      autofocus: false,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez remplir les champs';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          labelText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      autofocus: false,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez remplir les champs';
                        }
                        return null;
                      },
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          labelText: "Mot de passe",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      autofocus: false,
                      controller: confirmController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez remplir les champs';
                        }
                        return null;
                      },
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          labelText: "Confirmer le mot de passe",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    SizedBox(height: 15),
                    Container(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Menu()));
                              try {
                                final user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                                  final uid = user.uid;

                                  FirebaseFirestore.instance
                                      .collection('UserMobile')
                                      .doc(uid)
                                      .set({
                                    'Uid': uid,
                                    'Nom':
                                    nomController.value.text,
                                    'Prenom': prenomController
                                        .value.text,
                                    'Email': emailController.value.text,
                                    'Password': passwordController.value.text ,
                                    'Image':url
                                  })
                                      .then((value) => print("Utilisateur ajouté"))
                                      .catchError((error) =>
                                      print("Failed to add user: $error"));
                                }

                              } on FirebaseFirestore catch (e) {
                                print(e);
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar1);
                              } else if (e.code == 'email-already-in-use') {
                                ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: Text(
                          'Inscription',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
