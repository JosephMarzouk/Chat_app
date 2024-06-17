import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/showsnackbar.dart';
import 'package:chat_app/screens/Cubits/cubit/register_cubit.dart';
import 'package:chat_app/screens/chatScreen.dart';
import 'package:chat_app/screens/loginScreen.dart';
import 'package:chat_app/widgets/customButton.dart';
import 'package:chat_app/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;
  final String id = 'RegisterScreen';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if(state is RegisterLoading)
        {isLoading=true;}
        else if(state is RegisterSuccess)
        {
          Navigator.pushNamed(context, ChatScreen().id);
        }
        else if(state is RegisterFailed)
        {
          showSnackBar(context, state.errmess);
        }
      },
      builder: (context, state) {
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
                          BlocProvider.of<RegisterCubit>(context)
                              .RegisterUser(email: email!, password: password!);
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
                              Navigator.pop(context, LoginPage().id);
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
      },
    );
  }
}
