import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();

  @override
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    
    FirebaseFirestore.instance.collection('chatss').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username']
    });
    _controller.clear();
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
            child: TextField(
          controller: _controller,
          decoration: InputDecoration(labelText: 'Send Message'),
          onChanged: (value) {
            setState(() {
              _enteredMessage = value;
            });
          },
        )),
        IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(Icons.send)),
      ]),
    );
  }
}
