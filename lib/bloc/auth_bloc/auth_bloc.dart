import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'auth_event.dart';
part 'auth_state.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState()) {
    on<SignUpEvent>((event, emit) async {
      emit(LoadingAuthState());
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        await FirebaseAuth.instance.currentUser!.updateDisplayName(
          "${event.firstName} ${event.lastName}",
        );

        await FirebaseAuth.instance.currentUser!.reload();
        emit(SuccessAuthState());

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(FailureAuthState(message: 'The password provided is too weak.'));
        } else if (e.code == 'email-already-in-use') {
          emit(FailureAuthState(
              message: 'The account already exists for that email.'));
        } else {
          emit(FailureAuthState(message: e.message ?? 'Unknown error'));
        }
      } catch (e) {
        emit(FailureAuthState(message: e.toString()));
      }
    });

    // Login
    on<LoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email.trim(),
          password: event.password,
        );
        emit(LoginSuccessState());
      }  on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(LoginFauilreState(message: 'No user found for that email.'));
        } else if (e.code == 'wrong-password') {
          emit(LoginFauilreState(message: 'Wrong password provided.'));
        } else {
          emit(LoginFauilreState(message: e.message ?? 'Login failed.'));
        }
      } catch (e) {
        emit(LoginFauilreState(message: e.toString()));
      }
    });
  }
}