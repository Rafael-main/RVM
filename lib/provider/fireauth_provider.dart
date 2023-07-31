
import 'package:abc/models/fire_user.dart';
import 'package:abc/utils/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  String authType = '';
  String get getAuthType => authType;
  set setAuthType(String data) {
    authType = data;
    notifyListeners();
  }

  FireUser? fireCurrUser;
  FireUser? get getFireCurrUser => fireCurrUser;
  set setFireCurrUser(FireUser? data) {
    fireCurrUser = data;
    notifyListeners();
  }

  // FireUser 

  Future googleLogIn() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) => print('${value} AWAAA'));

    notifyListeners();
  }

  Future auth({loginType='', email='', pass=''}) async {
    setAuthType = loginType;
    if (loginType == 'google') {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
        _user = googleUser;

        final googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
        );

        await FirebaseAuth.instance.signInWithCredential(credential).then((value) => print('${value} AWAAA'));

        notifyListeners();
    }
    if (loginType == 'pass') {
      try {
        print(email);
        print(pass);
        // final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        //   email: emailAddress,
        //   password: password
        // );
        final credential = EmailAuthProvider.credential(email: email, password: pass);
        await FirebaseAuth.instance.signInWithCredential(credential).then((value) => print(value.toString()));
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }

  }

  Future createUserWithPasswordSignIn({emailAddress='', password=''}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      ).then((UserCredential val) async {
        print(val);
      });
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

  Future logout() async {
    if (getAuthType == 'google') {
      await googleSignIn.disconnect();
    }
    FirebaseAuth.instance.signOut();
  }
}