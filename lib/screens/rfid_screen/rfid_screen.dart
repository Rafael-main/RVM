import 'package:abc/provider/user_provider.dart';
import 'package:abc/screens/home/main_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/fire_user.dart';

class RfidScreen extends StatefulWidget {
  FireUser? data;
  RfidScreen({this.data, super.key});

  @override
  State<RfidScreen> createState() => _RfidScreenState();
}

class _RfidScreenState extends State<RfidScreen> {
  @override
  Widget build(BuildContext context) {

    Stream<DocumentSnapshot<Map<String, dynamic>>> checkUserIfHasRFID() => FirebaseFirestore.instance
      .collection('Users')
      .doc(widget.data!.uid)
      .snapshots();
    return Scaffold(
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: checkUserIfHasRFID(),
          builder: (context, snapshot) {
            if (snapshot.hasError){
              return Center(child: Text('Something Went wrong... ${snapshot.error}'));
            } else if (snapshot.hasData) {
              var dataUser = snapshot.data!.data();
              if (dataUser!['rfidtag'] == ''){
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('You are a new user. Please scan your RFID Tag'),
                      const Text('Once RFID is scanned, please enter the following to the RVM'),
                      Text('${dataUser['rfidpass']}'),
                    ],
                  ),
                );
              } else {

                return const Home(title: 'RVM');
              }
            }else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
      ),
    );
  }
}