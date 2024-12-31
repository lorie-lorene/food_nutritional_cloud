import 'package:flutter/material.dart';
import 'package:food_nutritional_cloud/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

import '../../../components/my_button.dart';
import '../../../components/my_text_field.dart';
import '../../../services/auth/auth_service.dart';
class Register extends StatefulWidget {
  final void Function()? onTap;
  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController =TextEditingController();
  final passWordController=TextEditingController();
  final confirmpassWordController=TextEditingController();

  //sign up
  void signUp() async{
    if (passWordController.text != confirmpassWordController.text){
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
           content: Text("password do not match"),
       ),
      );
      return ;
    }
    final authService= Provider.of<AuthService>(context,listen:false);
try{
  await authService.signUpWithEmailAndPassword(emailController.text, passWordController.text);
} catch(e)
{
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(e.toString())
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
                //create
                const Text(
                  "lest's create an account  ",
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
                    obscureText:false,
                    hintText: 'passWord'),
                //confirm password
                const SizedBox(height: 25),
                MyTextField(
                    controller:confirmpassWordController,
                    obscureText: false,
                    hintText: 'confirm passWord'),
                const SizedBox(height: 30),
                //sign up
                MyButton(onTap:signUp, text: "SIGN UP"),
                const SizedBox(height: 25),
                //register
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('have an account?'),
                   const  SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login  now',
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
