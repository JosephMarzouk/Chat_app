part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}


class LoginEvent extends AuthBlocEvent{

  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthBlocEvent{}