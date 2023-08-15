

import 'package:abc/models/leaderboard/leaderboard.dart';
import 'package:abc/provider/fireauth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../about/main_about.dart';


class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affec
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<List<Leaderboard>> readUsers() => FirebaseFirestore.instance
    .collection('Leaderboard')
    .orderBy('points')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => Leaderboard.fromJson(doc.data())).toList());

  Widget buildBoard(Leaderboard ranks, indexRank) => Card(
    child: ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        // child: FlutterLogo(),
        child: ranks.imageUrl != null ?  CircleAvatar(
          backgroundImage: NetworkImage(
            ranks.imageUrl ?? ''
          ),
        ) : Container(
          height: 50,
          width: 50,
          color: Colors.black87,
        )
      ),
      title: Text('Place ${ranks.username}'),
      subtitle: Text('Rank # $indexRank'),
      trailing: Text('${ranks.points} points'),
    ),
  );
 
  @override
  Widget build(BuildContext context) {
    final currUser = FirebaseAuth.instance.currentUser!;

    FirebaseAuthProvider fireAuthProv = Provider.of<FirebaseAuthProvider>(context, listen: false);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
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
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        // child: FlutterLogo(),
                        child: currUser.photoURL != null ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            currUser.photoURL!
                          ),
                        ) : Container(width: 100, height: 100, color: Colors.black87,)
                      ),
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
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) {
                      return Home(title: 'RVM',);
                    }
                  )
                );
      
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: const Text('About the app'),
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) {
                      return const About();
                    }
                  )
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: const Text('L O G O U T'),
              onTap: () {
                fireAuthProv.logout(); 
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return Center(child: Text('Something Went wrong... ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final rankings = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  // snap: true,
                  floating: true,
                  // expandedHeight: 250,
                  flexibleSpace: const FlexibleSpaceBar(
                    title: Text(
                      'Leaderboards', 
                      // textScaleFactor: 1,
                    ),
                    // background: Image.asset(name, fit:BoxFit.fill),
                  ),
                  actions: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
                    TextButton(
                      onPressed: (){
                        final authProvider = Provider.of<FirebaseAuthProvider>(context, listen:false);
                        authProvider.logout();
                      }, 
                      child: Text('Logout')
                    )

                  ],
                ),
                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //     (context, index) {
                //       return Card(
                //         child: ListTile(
                //           leading: FlutterLogo(),
                //           // // leading: Container(
                //           // //   padding: const EdgeInsets.all(8),
                //           // //   width: 100,
                //           // //   child: const Placeholder()
                //           // // ),
                //         title: Text('Place ${index + 1}'),
                //         subtitle: Text('Rank # ${index}'),
                //         trailing: Text('9999999 points'),
                //         ),
                //       );
                //     },
                //     childCount: 20,
                //   )
                // ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return buildBoard(rankings[index], index);
                      // return Text(userrrs[index].id);
                    },
                    childCount: rankings.length,
                  )
                ),
                
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}
