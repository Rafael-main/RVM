
import 'package:abc/utils/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogIn() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
  }

  Future login({
    provider = 'google-sign-in',
    emailAddress = '',
    password = '',

  }) async {
    if (provider == 'google-sign-in') {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      notifyListeners();
    } else if (provider == 'email-pass-sign-in') {
      if (emailAddress == '' && password == '') {
        return;
      }
      final credential =
          EmailAuthProvider.credential(email: emailAddress, password: password);
    }
    // Google Sign-in

    // Email and password sign-in

  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();

  }
}