import 'package:csnapp/inscrit.dart';
import 'package:csnapp/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Connect extends StatefulWidget {
  const Connect({Key? key}) : super(key: key);

  @override
  State<Connect> createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final snackBar = SnackBar(
    content: const Text('Bienvenue cher utilisateur'),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {

      },
    ),
  );
  final snackBar1 = SnackBar(
    content: const Text('Aucun utilisateur pour cet email'),
    action: SnackBarAction(
      label: 'Re-essayez',
      onPressed: () {

      },
    ),
  );

  final snackBar2 = SnackBar(
    content: const Text('Mot de passe Incorrect'),
    action: SnackBarAction(
      label: 'Re-essayez',
      onPressed: () {

      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: 420.0,
            width: 350.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 60,
                        child: Text('CSN App',
                          style: TextStyle(color: Colors.green,
                              fontWeight: FontWeight.bold,
                            fontSize: 40),
                          //Image.asset(
                          //"assets/icon.png",
                          //fit: BoxFit.contain,
                        )
                    ),
                    SizedBox(height: 30,),
                    SizedBox(
                      child: TextFormField(
                        autofocus: false,
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez remplir les champs';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: "Mail",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      child: TextFormField(
                        autofocus: false,
                        controller: passwordController,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez remplir les champs';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: "Mot de passe",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)
                            )
                        ),
                      ),
                    ),

                    SizedBox(height: 25,),
                    Container(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                          try {
                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar);
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Menu()));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar1);
                            } else if (e.code == 'wrong-password') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar2);
                            }
                          }
                          }
                        },
                        child: Text('Se Connecter',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),

                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Pas encore inscrit? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Inscrit()));
                          },
                          child: Text(
                            " Inscrivez-vous",
                            style: TextStyle(color: Colors.red,
                                fontWeight: FontWeight.w100,
                                fontSize: 15),),
                        )
                      ],
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