
import 'dart:html';

import 'package:abc/utils/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class PassSignInProvider extends ChangeNotifier {
  Future createUserWithPasswordSignIn({emailAddress='', password=''}) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

  }

  Future passLogin({
    emailAddress = '',
    password = '',

  }) async {
    try {
      // final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: emailAddress,
      //   password: password
      // );
      final credential = EmailAuthProvider.credential(email: emailAddress, password: password);
      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    // if (provider == 'email-pass-sign-in') {
    //   if (emailAddress == '' && password == '') {
    //     return;
    //   }
    //   credential =
    //       EmailAuthProvider.credential(email: emailAddress, password: password);
    //   await FirebaseAuth.instance.signInWithCredential(credential);
    // }

    // notifyListeners();
    // Google Sign-in

    // Email and password sign-in

  }

  Future passLogout() async {
    FirebaseAuth.instance.signOut();

  }
}