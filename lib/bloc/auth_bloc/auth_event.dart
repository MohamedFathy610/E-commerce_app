part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

final class SignUpEvent extends AuthEvent {

  final String firstName;
  final String lastName;
  final String email;
  final String password;


  SignUpEvent(this.firstName, this.lastName,
      {
        required this.email, required this.password

      });
}
final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}
