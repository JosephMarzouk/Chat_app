import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/showsnackbar.dart';
import 'package:chat_app/screens/chatScreen.dart';
import 'package:chat_app/screens/registerScreen.dart';
import 'package:chat_app/widgets/customButton.dart';
import 'package:chat_app/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  final String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  String? email,password;
 
  
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholer Chat',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'Pacifico'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                const Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                CustomTextFormField(hintText: 'E-mail',onChanged:(value){email=value;} ,),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(hintText: 'Password',onChanged:(value){password=value;},obscureText: true, ),
                const SizedBox(
                  height: 17,
                ),
                CustomButton(
                   ontap: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        isLoading = true;
                        setState(() {});
                        await loginUser();
                        Navigator.pushNamed(context, ChatScreen().id,arguments:email );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, 'user not found');
                        } else if (e.code == 'wrong-passowrd') {
                          showSnackBar(context, 'wrong password');
                        }
                      } catch (e) {
                        showSnackBar(context, 'There was an error');
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'LOGIN',
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dont have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterScreen().id);
                        },
                        child: const Text(
                          '  Register',
                          style: TextStyle(color: Color(0xffC7EDE6)),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  


  Future<void> loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
