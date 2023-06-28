import 'package:abc/utils/index.dart';

import 'package:abc/screens/about/main_about.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
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
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          currUser.photoURL!
                        ),
                      )
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
      body: Container(
        color: Colors.white,
        child: ListView(
          children: const [
            Text('sdsd')
          ]
        ),
      ),
    );
  }
}