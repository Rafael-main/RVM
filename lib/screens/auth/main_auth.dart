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
            const SizedBox(height: 32),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _usernameSignInController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'johndoe@email.com',
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _passwordSignInController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: '*****',
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Perform login validation here

                  // When user is valid then proceed to home
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                },
                child: const Text('Sign In'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
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
                label: const Text('Sign in with Google'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
