import 'package:abc/provider/user_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../provider/fireauth_pass_login_provider.dart';
import '../../provider/fireauth_provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
              child: Image.asset("assets/img/RVM Logo White BG.png")
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
                  labelText: 'Email',
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
                  final passSignInProv = Provider.of<PassSignInProvider>(context, listen: false);
                  passSignInProv.createUserWithPasswordSignIn(
                    emailAddress: _usernameSignInController.text,
                    password: _passwordSignInController.text
                  );
                  // Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                  Navigator.pushReplacementNamed(context, '/log');
                },
                child: const Text('Sign Up'),
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
                  final googleSignInProv = Provider.of<FirebaseAuthProvider>(context, listen: false);
                  googleSignInProv.googleLogIn();

                  
                  Navigator.pushReplacementNamed(context, '/log');

                },
                label: const Text('Sign up with Google'),
              ),
            ),
            
            const SizedBox(height: 20),
            SizedBox(
              // width: 300,
              // height: 45,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, '/log'),
                  child: const Text("Already have an account? Login here"),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}