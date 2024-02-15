import 'dart:developer';

import 'package:chat_app_flutter/extensions/build_context_extension.dart';
import 'package:chat_app_flutter/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chat Room'),
        elevation: 5,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  context.navigateToScreen(LoginScreen(), isReplace: true);
                });
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Column(children: [
        const Spacer(),
        Container(
          width: double.infinity,
          height: 100,
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 7.0, left: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: context.getWidth(percentage: 0.80),
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                        fillColor: Colors.white, filled: true),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          ),
        )
      ]),
    );
  }

  Future<void> sendMessage() async {
    log(FirebaseAuth.instance.currentUser!.uid);

    if (messageController.text.isNotEmpty) {
      final message = {
        'message': messageController.text,
        'senderUid': FirebaseAuth.instance.currentUser!.uid,
        'senderEmail': FirebaseAuth.instance.currentUser!.email,
        'timeStamp': DateTime.now().microsecondsSinceEpoch,
      };
      FirebaseFirestore.instance
          .collection('messages')
          .add(message)
          .then((value) {
        messageController.clear();
      });
    }
  }
}
