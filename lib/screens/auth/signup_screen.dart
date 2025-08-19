import 'package:e_commerce_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce_new/screens/components/home.dart';
import 'package:e_commerce_new/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_new/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccessAuthState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingAuthState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FailureAuthState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 100, 8, 8),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Welcome to Mohamed Fathy's store",
                        style: TextStyle(
                          color: AppColors.onPrimary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Please Sign Up to continue",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.onBackground,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // First + Last name
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) =>
                            value == null || value.isEmpty
                                ? 'Required'
                                : null,
                            onSaved: (value) => firstName = value,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            validator: (value) =>
                            value == null || value.isEmpty
                                ? 'Required'
                                : null,
                            onSaved: (value) => lastName = value,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    // Email
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        } else if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        ).hasMatch(value)) {
                          return 'Enter valid email';
                        }
                        return null;
                      },
                      onSaved: (value) => email = value,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 10),
                    // Password
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        } else if (value.length < 6) {
                          return 'Min 6 characters';
                        }
                        return null;
                      },
                      obscureText: true,
                      onSaved: (value) => password = value,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // Sign Up button
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          context.read<AuthBloc>().add(
                            SignUpEvent(
                              firstName!,
                              lastName!,
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
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.onPrimary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text('Log In'),
                        ),
                      ],
                    ),
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
