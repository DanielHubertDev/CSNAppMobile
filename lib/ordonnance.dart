import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Ordonnance extends StatefulWidget {
  const Ordonnance({Key? key}) : super(key: key);

  @override
  State<Ordonnance> createState() => _OrdonnanceState();
}

class _OrdonnanceState extends State<Ordonnance> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordonnance'),
     ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("InfoInscrit").snapshots(),
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
                          title: Text((documentSnapshot != null) ? (documentSnapshot["Nom"]) : ""),
                          subtitle: Text((documentSnapshot != null)
                              ? ((documentSnapshot["Email"] != null)
                              ? documentSnapshot["Email"]
                              : "")
                              : ""),
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
    );
  }
}
