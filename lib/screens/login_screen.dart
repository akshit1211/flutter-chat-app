import 'package:chat_app_flutter/custom/custom_text_field.dart';
import 'package:chat_app_flutter/extensions/build_context_extension.dart';
import 'package:chat_app_flutter/screens/chat_screen.dart';
import 'package:chat_app_flutter/screens/registration_screen.dart';
import 'package:chat_app_flutter/styles/constant_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Login',
          style: titleTextStyle,
        ),
        CustomTextField(
            controller: emailController,
            hintText: 'Email',
            isPassword: false,
            icon: Icons.email),
        CustomTextField(
            controller: passwordController,
            hintText: 'Password',
            isPassword: false,
            icon: Icons.lock),
        ElevatedButton(
            onPressed: () {
              loginUser();
            },
            child: const Text('Login Now')),
        GestureDetector(
          onTap: () {
            context.navigateToScreen(RegistrationScreen());
          },
          child: const Text("New User? Create a new account."),
        )
      ],
    ));
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      context.navigateToScreen(const ChatScreen(), isReplace: true);
    });
  }
}
