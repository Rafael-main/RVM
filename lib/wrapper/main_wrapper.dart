import 'package:abc/models/fire_user.dart';
import 'package:abc/provider/fireauth_provider.dart';
import 'package:abc/provider/user_provider.dart';
import 'package:abc/screens/auth/main_auth.dart';
import 'package:abc/screens/rfid_screen/rfid_screen.dart';
import 'package:abc/utils/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';


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
          var fireUserProv = Provider.of<FirebaseAuthProvider>(context, listen: false);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final currUser = FirebaseAuth.instance.currentUser!;
            print(currUser.providerData);
            print(currUser.metadata.runtimeType);
            Map<String, dynamic> meta = {
              'creationTime': currUser.metadata.creationTime,
              'lastTimeSignIn': currUser.metadata.lastSignInTime,
              'hashCode': currUser.metadata.hashCode,
            };
            Map<String, dynamic> data = {
              'displayName': currUser.displayName ?? '',
              'email': currUser.email ?? '',
              'isAnonymous': currUser.isAnonymous,
              'metadata': meta,
              'phoneNumber': currUser.phoneNumber,
              'photoURL': currUser.photoURL,
              'providerData': currUser.providerData,
              'refreshToken': currUser.refreshToken,
              'tenantId': currUser.tenantId,
              'uid': currUser.uid,
            };
            var fireUserData = FireUser.fromJson(data);
            // WidgetsBinding.instance.addPostFrameCallback((_){
            //   fireUserProv.setFireCurrUser = FireUser.fromJson(data);
            // });
            print(fireUserProv.getFireCurrUser?.uid ?? 'ALKGJWRLKG');
            // final db = FirebaseFirestore.instance;
            // final docRef = db.collection("Users").doc(currUser.uid);
            // print(docRef);
            // print(docRef.get());
            // docRef.get().then(
            //   (doc) {
            //     if (doc.exists){
            //       Map<String, dynamic> data = {
            //         'id': doc['id'],
            //         'imageUrl': doc['imageURL'],
            //         'name': doc['name'],
            //         'points': doc['points'],
            //         'public': doc['public'],
            //         'rank': doc['rank'],
            //         'rfidtag': doc['rfidtag'],
            //         'username': doc['username']
            //       };
            //       userProv.setCurrUser = Userr.fromJson(data);
            //     } else {
            //       // int referenceID = Random().nextInt(100000) + 1000000;
            //       Userr data = Userr(
            //         id: currUser.uid, 
            //         imageUrl: currUser.photoURL ?? '', 
            //         points: 0, 
            //         public: true, 
            //         rank: 999, 
            //         rfidtag: '', 
            //         username: currUser.email ?? '',
            //         name: currUser.displayName ?? ''
            //       );
            //       userProv.setCurrUser = data;
            //       db
            //       .collection("Users")
            //       .doc(currUser.uid)
            //       .set(data.toJson())
            //       .then((value) => print('yey'))
            //       .onError((e, _) => print("Error writing document: $e"));

            //       print('YAWA NAHUMAN MAN NAKO');
            //     }
            //   },
            //   onError: (e) => print("Error getting document: $e"),
            // );

            // return const Scaffold(body: Text(''),);
            // return Center(child: Container(child: Text('${currUser.providerData[0].uid}'),));
            return RfidScreen(data: fireUserData);
            
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