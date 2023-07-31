import 'package:abc/provider/user_provider.dart';
import 'package:abc/utils/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> { 
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool publicAccount = false;

  void updatePublicRecord(String docID, Map<String,dynamic> data){
    FirebaseFirestore.instance
      .collection("Users")
      .doc(docID)
      .update(data).then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    var userProv = context.watch<UserProvider>().currUser;
    final currUser = FirebaseAuth.instance.currentUser!;
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
              // // child: Center(child: Text('Drawer Header')),
              // child: Center(
              //   // child: Text('Drawer Header')
              //   child: CircleAvatar(
              //     child: FlutterLogo(),
              //   ),
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      // child: FlutterLogo(),
                      child: currUser.photoURL != null ?  CircleAvatar(
                        backgroundImage: NetworkImage(
                          currUser.photoURL ?? ''
                        ),
                      ) : FlutterLogo()
                    ),
                  ),
                  Text(currUser.displayName!),
                  Text(currUser.email!)
                ],
              )
            ),
            ListTile(
              leading: const Icon(Icons.person_2_outlined),
              title: const Text('Profile'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushNamedAndRemoveUntil(context, '/profile', (_) => false);
                // Navigator.push(
                //   context, MaterialPageRoute(
                //     builder: (context) {
                //       return const Profile();
                //     }
                //   )
                // );
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_awesome_sharp),
              title: const Text('Leaderboards'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                // Navigator.push(
                //   context, MaterialPageRoute(
                //     builder: (context) {
                //       return Home(title: 'RVM',);
                //     }
                //   )
                // );
      
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: const Text('About the app'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/about', (_) => false);
                // Navigator.push(
                //   context, MaterialPageRoute(
                //     builder: (context) {
                //       return const About();
                //     }
                //   )
                // );// Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('Rank'),
                      Text(
                        // '${userProv!.rank}',
                        '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 42
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Points'),
                      Text(
                        // '${userProv.points}',
                        '',
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
                          // updatePublicRecord(userProv.id, changeToPublic);
      
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
          ),
        ),
      ),
    );
  }
}