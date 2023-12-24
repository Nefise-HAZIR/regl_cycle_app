import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regl_cycle_app/resources/auth_methods.dart';
import 'package:regl_cycle_app/screens/home_screen.dart';
import 'package:regl_cycle_app/screens/signup_screen.dart';
import 'package:regl_cycle_app/widget/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isloading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/welcome.jfif",
                  fit: BoxFit.cover,
                ),
                TextFieldInput(
                    controller: _emailController,
                    type: TextInputType.emailAddress,
                    hintText: "please enter your email"),
                const SizedBox(
                  height: 30,
                ),
                TextFieldInput(
                  controller: _passwordController,
                  type: TextInputType.text,
                  hintText: "please enter your password",
                  isPassword: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 15),
                        backgroundColor: const Color(0xFFc9ada7)),
                    onPressed: () async {
                      setState(() {
                        isloading = true;
                      });
                      String res = await AuthMethods().loginUser(
                          email: _emailController.text,
                          password: _passwordController.text);
                      if (res == "success") {
                        var uid = auth.currentUser!.uid;
                        const CircularProgressIndicator();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return HomeScreen(
                              uid: uid,
                            );
                          }),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Please ensure your email and password")));
                      }
                      setState(() {
                        isloading = false;
                      });
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't you have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const SignUpScreen();
                        }));
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
