// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseinstance = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter chat'),
        actions: [
          DropdownButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout')
                  ]),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: firebaseinstance
              .collection('chat/bcIgAtYMh5FFFcDWnleT/messages')
              .snapshots(),
          builder: (ctx,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                  streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = streamSnapshot.data!.docs;
            return ListView.builder(
              itemBuilder: (ctx, i) => Container(
                padding: const EdgeInsets.all(8),
                child: Text(documents[i]['text']),
              ),
              itemCount: documents.length,
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            firebaseinstance
                .collection('chat/bcIgAtYMh5FFFcDWnleT/messages')
                .add({'text': 'Added'});
          },
          child: const Icon(Icons.add)),
    );
  }
}
