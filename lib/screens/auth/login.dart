
import 'package:e_commerce_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce_new/screens/home.dart';
import 'package:e_commerce_new/screens/auth/signup_screen.dart';
import 'package:e_commerce_new/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_new/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';


import '../../bloc/auth_bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>(); // the key that validate fields
  String? email;
  String? password;


  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (state is LoginFauilreState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },

        builder: (context, state) {
          if (state is LoginLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 100, 8, 8),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  _welcomeText(),
                  const SizedBox(height: 20),
                  _loginText(),
                  const SizedBox(height: 20),
                  _emailTextField((value) {
                    email = value;
                  }),
                  const SizedBox(height: 10),
                  _passwordTextField((value) {
                    password = value;
                  }),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        context.read<AuthBloc>().add(
                          LoginEvent(
                            email: email!,
                            password: password!,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: const Text(
                      AppStrings.login,
                      style: TextStyle(fontSize: 30,
                          color: AppColors.onPrimary),
                      selectionColor: AppColors.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _goToSignUp(context),
                  const SizedBox(height: 10),
                  _sigInWithGoogle(),
                ],
              ),
            ),
          ),
          );
        },
      ),
    );
  }
}




Widget _welcomeText() {
  return  Container(
    height: 150,
    width: 300,
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(100),
    ),
    child: Text(
      AppStrings.welcomeMessage,
      style: TextStyle(
        color: AppColors.onPrimary,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),

      textAlign: TextAlign.center,
    ),
  );
}
Widget _loginText() {
  return const Text(
    AppStrings.loigntext,
    style: TextStyle(fontSize: 20, color: AppColors.onBackground),
  );
}
Widget _emailTextField(Function(String?) onSaved) {
  return TextFormField(
    onSaved:onSaved,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return AppStrings.requiredField;
      }
      else if (!RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(value)) {
        return AppStrings.invalidEmail;
      }
    },
    decoration: InputDecoration(
      labelText: AppStrings.email,
      hintText: AppStrings.emaailHint,
      border: OutlineInputBorder(),
    ),
  );
}
Widget _passwordTextField(Function(String?) onSaved) {
  return TextFormField(
    onSaved:onSaved,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return AppStrings.requiredField;
      }
      else if (value.length < 6) {
        return AppStrings.passwordMinLength;
      }
    },
    obscureText: true,
    decoration: InputDecoration(
      labelText: AppStrings.password,
      hintText: AppStrings.passwordHint,
      border: OutlineInputBorder(),
    ),
  );
}
Widget _goToSignUp(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(AppStrings.noAccount),
      TextButton(
        onPressed: () {
          // Handle sign up navigation here
          Navigator.pushReplacement(
            // replace the last screen with this
            context,
            MaterialPageRoute(
              builder: (context) {
                return SignUpScreen();
              },
            ),
          );
        },
        child: const Text(AppStrings.signup,
          style: TextStyle(color: AppColors.primary),
      )
      ),
    ],
  );
}
Widget _sigInWithGoogle() {
  return ElevatedButton.icon(
    onPressed: () {
      // Handle Google Sign-In here
    },
    icon: const Icon(Icons.login),
    label: const Text('Sign in with Google'
      , style: TextStyle(fontSize: 20, color: AppColors.onPrimary)
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      textStyle: const TextStyle(fontSize: 20),
    ),
  );
}
