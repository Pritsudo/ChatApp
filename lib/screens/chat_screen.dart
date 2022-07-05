// import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
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
      body: Container(
        child: Column(children: [
          Expanded(child: Messages()),
          NewMessage(),
        ],),
      ),
     
    );
  }
}
