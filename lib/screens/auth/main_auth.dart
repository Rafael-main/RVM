import 'package:abc/provider/fireauth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameSignInController = TextEditingController();
  final TextEditingController _passwordSignInController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width:  100,
              color: Colors.black,
              child: FlutterLogo()
            ),
            // Image.asset(
            //   'assets/logo.png',
            //   height: 120,
            // ),
            SizedBox(height: 32),
            Container(
              width: 300,
              child: TextField(
                controller: _usernameSignInController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'johndoe@email.com',
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 300,
              child: TextField(
                controller: _passwordSignInController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: '*****',
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 300,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Perform login validation here

                  // When user is valid then proceed to home
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                },
                child: Text('Sign In'),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 300,
              height: 45,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black
                ),
                icon: const FaIcon(FontAwesomeIcons.google),
                onPressed: () {
                  // Perform sign in with Google here
                  final googleSignInProv = Provider.of<GoogleSignInProvider>(context, listen: false);
                  googleSignInProv.googleLogIn();

                },
                label: Text('Sign in with Google'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
