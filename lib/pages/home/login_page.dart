import 'package:flutter/material.dart';
import 'package:food_nutritional_cloud/components/my_button.dart';
import 'package:food_nutritional_cloud/components/my_text_field.dart';
import 'package:food_nutritional_cloud/services/auth/auth_service.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text edition
  final emailController =TextEditingController();
  final passWordController=TextEditingController();
  Future<void> signIn() async {
final authService=Provider.of<AuthService>(context,listen: false);
try{
  await authService.signInWithEmailandPassword(emailController.text, passWordController.text);
}
catch (e){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString(),
  ),
  ),
  );
}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
          child: Center(
            child:   Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  // logo
                  const Icon(
                    Icons.message,
                    size: 100,
                  ),
                  //welcomw
                  const Text(
                    "welcome back ",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  // email
                  MyTextField(
                      controller:emailController,
                      obscureText: false,
                      hintText: 'email'),
                  //password
                  const SizedBox(height: 25),
                  MyTextField(
                      controller:passWordController,
                      obscureText: true,
                      hintText: 'passWord'),
                  const SizedBox(height: 30),
                  //sign in
              MyButton(onTap:signIn, text: "SIGN IN"),
                  const SizedBox(height: 25),
                  //register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('have not an account?'),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,color: Colors.black,
                        ),
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
      ),

    );
  }
}
