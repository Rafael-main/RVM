import 'package:abc/screens/auth/main_auth.dart';
import 'package:abc/screens/auth/main_sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abc/utils/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user/userr.dart';


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
            final currUser = FirebaseAuth.instance.currentUser!;
            print(currUser.displayName);
            print(currUser.uid);

            // Stream<List<Userr>> readUsers() => FirebaseFirestore.instance
            // .collection('Leaderboard')
            // .orderBy('points')
            // .snapshots()
            // .map((snapshot) => snapshot.docs.map((doc) => Userr.fromJson(doc.data())).toList());
            
            return const Home(title: 'RVM');
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