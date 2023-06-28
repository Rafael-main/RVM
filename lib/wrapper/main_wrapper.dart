import 'package:abc/screens/auth/main_auth.dart';
import 'package:abc/screens/auth/main_sign_up.dart';
import 'package:abc/utils/index.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const Home(title: 'ABC');
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something Went Wrong!'),);
          } else {
            return SignInPage();
          }
        },
        
      ),
    );
  }
}