import 'package:abc/screens/auth/main_auth.dart';
import 'package:abc/screens/rfid_screen/rfid_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abc/utils/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user/userr.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});


  @override
  Widget build(BuildContext context) {
    Future<void> _showErrorDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('AlertDialog Title'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/log');
                },
              ),
            ],
          );
        },
      );
    }
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final currUser = FirebaseAuth.instance.currentUser!;
            final db = FirebaseFirestore.instance;

            final docRef = db.collection("Users").doc(currUser.uid);
            docRef.get().then(
              (DocumentSnapshot doc) {
                if (doc.exists){
                  final data = doc.data() as Map<String, dynamic>;
                  Userr.fromJson(data);
                  return const Home(title: 'RVM');
                } else {
                  Userr data = Userr(id: currUser.uid, imageUrl: currUser.photoURL ?? '', points: 0, public: true, rank: 999, rfidtag: '', username: currUser.email ?? '', name: currUser.displayName ?? '');
                  db
                  .collection("Users")
                  .doc(currUser.uid)
                  .set(data.toJson())
                  .onError((e, _) => print("Error writing document: $e"));

                  return const RfidScreen();
                }
              },
              onError: (e) => print("Error getting document: $e"),
            );

            return Scaffold(
              body: Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, '/log'),
                  child: const Text('Something went wrong. Proceed to login again.'),
                ),
                
              ),
            );
            
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