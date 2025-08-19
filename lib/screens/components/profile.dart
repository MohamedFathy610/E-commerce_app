import 'package:e_commerce_new/bloc/theme_cubit/theme_cubit.dart';
import 'package:e_commerce_new/screens/auth/login.dart';
import 'package:e_commerce_new/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _welcomeMessage(context),
            const SizedBox(height: 20),
            _showName(context),
            const SizedBox(height: 10),
            _showEmail(context),
            const SizedBox(height: 20),
            _EditTheme(context),
            const SizedBox(height: 20),

            const SizedBox(height: 20),
            _logOuut(context),
          ],
        ),
      ),
    );
  }
}

Widget _welcomeMessage(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  return Text(
    "Welcome, ${user?.displayName }!",
    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
  );
}

Widget _showName(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  return TextField(
    controller: TextEditingController(text: user?.displayName ?? ""),
    decoration: InputDecoration(
      labelText: AppStrings.name,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    readOnly: true, );// Make it read-only for now
}

Widget _showEmail(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  return TextField(
    controller: TextEditingController(text: user?.email ?? ""),
    decoration: InputDecoration(
      labelText: AppStrings.email,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    readOnly: true, // Make it read-only for now
  );
}
Widget _EditTheme(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: TextField(
          controller: TextEditingController(
            text: "Theme : ${BlocProvider.of<ThemeCubit>(context).isDark ? "Dark" : "Light"}",
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            labelText: AppStrings.theme,
          ),
          readOnly: true, // read-only
        ),
      ),
      const SizedBox(width: 10),
      _changeTheme(context),
    ],
  );
}
Widget _changeTheme(BuildContext context) {
  return ElevatedButton(
    onPressed: () => BlocProvider.of<ThemeCubit>(context).toggleTheme(),
    child: const Text(AppStrings.changeTheme,
        style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold)
    ),
  );
}

Widget _logOuut (BuildContext context) {
  return ElevatedButton(

    onPressed: ()async {
      await FirebaseAuth.instance.signOut();
      // Navigate to login screen after logging out
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    },

    child: const Text(AppStrings.logout,
      style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold)
    ),


  );
}

