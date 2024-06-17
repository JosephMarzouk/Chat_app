part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}
final class LoginLoading extends AuthBlocState {}
final class LoginSuccess extends AuthBlocState {}
final class LoginFailed extends AuthBlocState {
 final String errmess;

  LoginFailed({required this.errmess});

}


final class RegisterLoading extends AuthBlocState {}
final class RegisterSuccess extends AuthBlocState {}
final class RegisterFailed extends AuthBlocState {
 final String errmess;

  RegisterFailed({required this.errmess});

}