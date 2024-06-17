import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/Cubits/cubit/chat_cubit.dart';
import 'package:chat_app/screens/Cubits/cubit/login_cubit.dart';
import 'package:chat_app/screens/Cubits/cubit/register_cubit.dart';
import 'package:chat_app/screens/Simple_Bloc_Observer.dart';
import 'package:chat_app/screens/blocs/autth_bloc/auth_bloc_bloc.dart';
import 'package:chat_app/screens/chatScreen.dart';
import 'package:chat_app/screens/loginScreen.dart';
import 'package:chat_app/screens/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  BlocOverrides.runZoned(() {
    runApp(const ChatApp());
  }, blocObserver: SimpleBlocObserver());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBlocBloc(),
        ),
      ],
      child: MaterialApp(
        routes: {
          LoginPage().id: (context) => LoginPage(),
          RegisterScreen().id: (context) => RegisterScreen(),
          ChatScreen().id: (context) => ChatScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
