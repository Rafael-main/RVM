import 'package:abc/provider/user_provider.dart';
import 'package:abc/utils/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> { 
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool publicAccount = false;



  @override
  Widget build(BuildContext context) {
    // current user logged in
    final currUser = FirebaseAuth.instance.currentUser!;

    // update record 
    Future<void> updatePublicRecord(String docID, Map<String,dynamic> data) async {
      return await FirebaseFirestore.instance
        .collection("Users")
        .doc(docID)
        .update(data).then((value) => null);
    }

    // read user profile
    final Stream _usersStream = FirebaseFirestore.instance
    .collection('Users')
    .doc(currUser.uid)
    .snapshots();

    // add user to leaderboards 
    Future<void> addLeaderboards(uid, data) {
      // Call the user's CollectionReference to add a new user
      CollectionReference users = FirebaseFirestore.instance.collection('Leaderboard');
      return users
        .doc(uid)
        .set(data)
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
    Future<void> deleteUserFromLeaderBoards(uid) {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      return users
        .doc(uid)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red[800],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: currUser.photoURL != null ?  CircleAvatar(
                        backgroundImage: NetworkImage(
                          currUser.photoURL ?? ''
                        ),
                      ) : Container(
                        height: 100,
                        width: 100,
                        color: Colors.black87,
                      )
                    ),
                  ),
                  Text(currUser.displayName ?? ''),
                  Text(currUser.email ?? '')
                ],
              )
            ),
            ListTile(
              leading: const Icon(Icons.person_2_outlined),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/profile', (_) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_awesome_sharp),
              title: const Text('Leaderboards'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: const Text('About the app'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/about', (_) => false);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.white,
          child: StreamBuilder(
            stream: _usersStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong with the server. Try again later'),
                );
              }
              else if (snapshot.hasData) {
                print(snapshot.data['points']);
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text('Points'),
                            Text(
                              // '${userProv.points}',
                              "${snapshot.data['points'] ?? ''}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 42
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text('Name'),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 16),
        
                    SizedBox(
                      child: Row(
                        children: [
                          const Text('Public:'),
                          Switch(
                            // This bool value toggles the switch.
                            value: publicAccount,
                            activeColor: Colors.red,
                            onChanged: (bool value) {
                              if (value == true) {
                                Map<String, dynamic> changeToPublic = {"public":value};
                                updatePublicRecord(currUser.uid, changeToPublic);
                                print('SAVED TO DATABASE');
                                Map<String, dynamic> addToLeaderBoardsData = {
                                  'docId': currUser.uid, 
                                  'imageURL': currUser.photoURL ?? '', 
                                  'points': snapshot.data['points'],
                                  'userID': currUser.uid,
                                  'username': currUser.displayName ?? ''
                                };
                                addLeaderboards(currUser.uid, addToLeaderBoardsData);
                              } else {
                                deleteUserFromLeaderBoards(currUser.uid);
                              }
                              print(value);
                              // This is called when the user toggles the switch.
                              setState(() {
                                publicAccount = value;
        
                              });
                            },
                          )
                        ],
                      ),
                    )
                    
                  ]
                );
              }
              else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          ),
        ),
      ),
    );
  }
}