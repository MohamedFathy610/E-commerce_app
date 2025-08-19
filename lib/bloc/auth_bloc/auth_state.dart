part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginFauilreState extends AuthState {
  final String message;

  LoginFauilreState({required this.message});
}

class FailureAuthState extends AuthState {
  final String message;

  FailureAuthState({required this.message});
}