
import 'package:apd110_sakshidali/spashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC8I1qz7rX-KbLoXCExrktznLuZfdLsGto",
      appId: "1:899267467466:android:9450d1eda5881c93633c33",
      messagingSenderId: "899267467466",
      projectId: "civorax-app",
      storageBucket: "civorax-app.firebasestorage.app"
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Market Reach App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: SplashScreen(),
    );
  }
}
