import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:idleread/modals/colors.dart';
import 'package:idleread/services/firebase_options.dart';
import 'package:idleread/ui/homescreen.dart';
import 'package:idleread/ui/readScreen.dart';
import 'package:idleread/ui/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    myColors mcol = myColors();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            primaryColor: mcol.lightorange,
            secondaryHeaderColor: mcol.lightorange,
            textSelectionTheme: TextSelectionThemeData(
                selectionColor: mcol.lightorange.withOpacity(0.3),
                selectionHandleColor: mcol.lightorange)),
        home: (FirebaseAuth.instance.currentUser?.uid != null)
            ? HomeScreen()
            : WelcomeScreen());
  }
}
