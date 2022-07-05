
import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx,
          AsyncSnapshot<QuerySnapshot<Map<String , dynamic>>> chatSnapshot) {
        final chatDocs = chatSnapshot.data!.docs;

        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
              return ListView.builder(
                reverse: true,
                itemBuilder: (context, index) => MessageBubble(
                    message: chatDocs[index]['text'],
                    userName: chatDocs[index]['username'],
                    userImage: chatDocs[index]['userImage'],
                    isMe: chatDocs[index]['userId']==userId,
                    key: ValueKey(chatDocs[index].id),
                    ),
                itemCount: chatDocs.length,
              );
            
      },
    );
  }
}
