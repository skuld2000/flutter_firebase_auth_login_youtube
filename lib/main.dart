import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_login_youtube/screens/login.dart';
import 'screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
    );
  }
}
