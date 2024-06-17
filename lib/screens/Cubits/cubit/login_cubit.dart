import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            emit(LoginFailed(errmess: 'user-not-found'));
                          } else if (e.code == 'wrong-passowrd') {
                            emit(LoginFailed(errmess:'wrong-passowrd'));
                          }
                        }
    on Exception {
      emit(LoginFailed(errmess: 'something went wrong'));
    }
  }
}
