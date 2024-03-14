import 'package:chat_app_fire_base/screens/auth.dart';
import 'package:chat_app_fire_base/screens/chat.dart';
import 'package:chat_app_fire_base/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// Follow instructions here for Firebase: https://firebase.google.com/docs/flutter/setup

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          
          // Loading screen while the tokens load
          if(snapshot.connectionState == ConnectionState.waiting){
            return const SplashScreen();
          }

          if (snapshot.hasData) {
            return const ChatScreen();
          }

          return const AuthScreen();
        },
      ),
    );
  }
}
