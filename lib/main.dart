import 'package:abc/provider/fireauth_provider.dart';
import 'package:abc/provider/user_provider.dart';
import 'package:abc/screens/about/main_about.dart';
import 'package:abc/screens/auth/main_auth.dart';
import 'package:abc/screens/home/main_home.dart';
import 'package:abc/screens/profile/main_profile.dart';
import 'package:abc/screens/register/register.dart';
import 'package:abc/wrapper/main_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'provider/fireauth_pass_login_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PassSignInProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RVM',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        routes: {
          '/':(context) => const Wrapper(),
          '/log':(context) => SignInPage(),
          '/home':(context) => const Home(title: "RVM"),
          '/profile': (context) => const Profile(),
          '/about': (context) => const About(),
          '/register': (context) => const Register()
        },
      ),
    );
  }
}
