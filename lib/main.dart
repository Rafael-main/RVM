import 'package:abc/provider/fireauth_provider.dart';
import 'package:abc/screens/about/main_about.dart';
import 'package:abc/screens/auth/main_auth.dart';
import 'package:abc/screens/home/main_home.dart';
import 'package:abc/screens/profile/main_profile.dart';
import 'package:abc/wrapper/main_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RVM',
        theme: ThemeData(
          // This is the theme of your application.
          //`
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        routes: {
          // '/':(context) => LoginPage(),
          '/home':(context) => const Home(title: "RVM"),
          '/profile': (context) => const Profile(),
          '/about': (context) => const About()
        },
        // home: const Home  (title: 'Flutter Demo Home Page'),
        home: const Wrapper()
      ),
    );
  }
}
