import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/showsnackbar.dart';
import 'package:chat_app/screens/chatScreen.dart';
import 'package:chat_app/screens/loginScreen.dart';
import 'package:chat_app/widgets/customButton.dart';
import 'package:chat_app/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  final String id = 'RegisterScreen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email,password;

  

  bool isLoading = false;

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
                      'REGISTER',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                CustomTextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    hintText: 'E-mail'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                   obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    hintText: 'Password'),
                const SizedBox(
                  height: 17,
                ),
                CustomButton(
                  ontap: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        isLoading = true;
                        setState(() {});
                        await registerUser();
                        showSnackBar(context, 'successed');
                        Navigator.pushNamed(context, ChatScreen().id,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, 'weak password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'email already in use');
                        }
                      } catch (e) {
                        showSnackBar(context, 'There was an error');
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'REGISTER',
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context, LoginScreen().id);
                        },
                        child: const Text(
                          '  Login',
                          style: TextStyle(color: Color(0xffC7EDE6)),
                        ))
                  ],
                ),
                const Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

 

  Future<void> registerUser() async {
     await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
