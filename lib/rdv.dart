import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rdv extends StatefulWidget {
  const Rdv({Key? key}) : super(key: key);

  @override
  State<Rdv> createState() => _RdvState();
}

class _RdvState extends State<Rdv> {
  List todos = List.empty();
  String title = "";
  String description = "";
  @override
  void initState() {
    super.initState();
    todos = ["Hello", "Hey"];
  }

  createToDo() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("Mes rendez-vous").doc(title);

    Map<String, String> todoList = {
      "titre": title,
      "description": description
    };

    documentReference
        .set(todoList)
        .whenComplete(() => print("données sauvegader"));
  }

  deleteTodo(item) {

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("Mes rendez-vous").doc(item);

    documentReference.delete().whenComplete(() => print("supprimer"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RENDEZ-VOUS"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Mes rendez-vous").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('une erreur');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                  snapshot.data?.docs[index];
                  return Dismissible(
                      key: Key(index.toString()),
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text((documentSnapshot != null) ? (documentSnapshot["titre"]) : ""),
                          subtitle: Text((documentSnapshot != null)
                              ? ((documentSnapshot["description"] != null)
                              ? documentSnapshot["description"]
                              : "")
                              : ""),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_forever),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                //todos.removeAt(index);
                                deleteTodo((documentSnapshot != null) ? (documentSnapshot["titre"]) : "");
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("${title} Suprimer")));
                            },
                          ),
                        ),
                      ));
                });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: const Text("Ajouter un rendez-vous"),
                  content: Container(
                    width: 400,
                    height: 100,
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Titre:',
                          ),
                          onChanged: (String value) {
                            title = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Déscription:',
                          ),
                          onChanged: (String value) {
                            description = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          setState(() {
                            //todos.add(title);
                            createToDo();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ajouter"))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}