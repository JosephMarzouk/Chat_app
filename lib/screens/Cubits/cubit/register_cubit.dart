import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());


  Future<void> RegisterUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());

    try {
       await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
                          if (e.code == 'email-already-in-use') {
                            emit(RegisterFailed(errmess: 'email-already-in-use'));
                          } else if (e.code == 'weak-passowrd') {
                            emit(RegisterFailed(errmess:'weak-passowrd'));
                          }
                        }
    on Exception {
      emit(RegisterFailed(errmess: 'something went wrong'));
    }
  }
}
