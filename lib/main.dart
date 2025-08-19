import 'package:e_commerce_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce_new/bloc/theme_cubit/theme_cubit.dart';
import 'package:e_commerce_new/screens/components/home.dart';
import 'package:e_commerce_new/screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_new/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Mohamed Fathy Store',
            theme: ThemeData(
              colorScheme: state is ThemeDark
                  ? ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              )
                  : ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: FirebaseAuth.instance.currentUser != null
                ? const HomePage()
                : const LoginScreen());
        },
      ),
    );
  }
}
