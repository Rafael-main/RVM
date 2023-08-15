import 'package:abc/provider/fireauth_provider.dart';
import 'package:abc/provider/user_provider.dart';
import 'package:abc/screens/home/main_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../models/fire_user.dart';
import '../../models/user/userr.dart';

class RfidScreen extends StatelessWidget {
  FireUser? data;
  RfidScreen({this.data, super.key});

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> checkUserIfHasRFID() => FirebaseFirestore.instance
      .collection('Users')
      .doc(data!.uid)
      .snapshots();
    return Scaffold(
      body: StreamBuilder<Object>(
        stream: checkUserIfHasRFID(),
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return Center(child: Text('Something Went wrong... ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return const Home(title: 'RVM');
          }else {
            return const Center(
              child: Text('You are a new user. Please scan your RFID Tag'),
            );
            // return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}