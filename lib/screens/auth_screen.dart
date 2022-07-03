import 'package:chat_app/widgets/auth_form.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(String email, String password, String username,
      bool isLogin, BuildContext ctx) async {
    UserCredential cred;

    try {
      setState(() {
        _isLoading = true;
      });

      if (isLogin) {
        cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(cred.user!.uid)
            .set({
          'username': username,
          'email': email,
          'uid': cred.user!.uid,
        });
      }
      
    } on PlatformException catch (err) {
      var message = ' An error occured , please check your credentails!';
      if (err.message != null) {
        message = err.message.toString();
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      _isLoading = false;
    } catch (err) {
      print(err);
      // ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      //   content: Text(err.toString()),
      //   backgroundColor: Theme.of(ctx).errorColor,
      // ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(submitFn: _submitAuthForm, isLoading: _isLoading),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
