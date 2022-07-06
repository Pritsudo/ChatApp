// import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  void initState() {
  super.initState();
  final fbm = FirebaseMessaging.instance;
  fbm.requestPermission();
  FirebaseMessaging.onMessage.listen((message) {
    print(message);
    return;
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print(message);
    return;
  });
  // fbm.subscribeToTopic('chat');
}
  
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
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
