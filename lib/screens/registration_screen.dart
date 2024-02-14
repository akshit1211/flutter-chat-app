import 'dart:developer';

import 'package:chat_app_flutter/custom/custom_text_field.dart';
import 'package:chat_app_flutter/extensions/build_context_extension.dart';
import 'package:chat_app_flutter/modal/users.dart';
import 'package:chat_app_flutter/screens/chat_screen.dart';
import 'package:chat_app_flutter/styles/constant_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Registration',
          style: titleTextStyle,
        ),
        CustomTextField(
            controller: nameController,
            hintText: "Name",
            isPassword: false,
            icon: Icons.person),
        CustomTextField(
            controller: emailController,
            hintText: 'Email',
            isPassword: false,
            icon: Icons.visibility),
        CustomTextField(
            controller: passwordController,
            hintText: 'Password',
            isPassword: true,
            icon: Icons.visibility_off),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    registerNewUser();
                  },
                  child: const Text('Register Now!'))),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text("Already Registered? Login Instead."),
        ),
      ]),
    );
  }

  Future<void> registerNewUser() async {
    final email = emailController.text;
    final password = passwordController.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          log(value.user!.uid);
          addDataToDatabase(uid: value.user!.uid);
        },
      );
    }
  }

  Future<void> addDataToDatabase({required String uid}) async {
    final user = Users(nameController.text, emailController.text, uid,
        passwordController.text, true, 'say cheese');
    FirebaseFirestore.instance
        .collection('users')
        .add(user.toJson())
        .then((value) {
      log('user created succesfully');
      context.navigateToScreen(const ChatScreen(), isReplace: true);
    }).catchError((e) {
      log('failed to create user $e');
    });
  }
}
