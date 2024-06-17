import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<AuthBlocEvent>((event, emit) async {
      if (event is LoginEvent) {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailed(errmess: 'user-not-found'));
          } else if (e.code == 'wrong-passowrd') {
            emit(LoginFailed(errmess: 'wrong-passowrd'));
          }
        } on Exception {
          emit(LoginFailed(errmess: 'something went wrong'));
        }
      }
    });
  }
}
