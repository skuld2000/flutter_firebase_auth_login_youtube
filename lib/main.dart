import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_login_youtube/screens/main_page.dart';
import 'data/join_or_login.dart';
import 'screens/login.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
    );
  }
}

//로그인, 로그아웃 여부에 따라 다른 화면을 보여줌
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize FlutterFire
    Firebase.initializeApp();

    return StreamBuilder<User>(
        //authStateChanges : 로그인, 로그아웃 변경사항을 Stream<User> 로 리턴
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            //로그인 정보 없으면
            return ChangeNotifierProvider<JoinOrLogin>.value(
                value: JoinOrLogin(),
                //로그인, 가입 페이지
                child: AuthPage());
          } else {
            //로그인 정보 있으면
            return MainPage(email: snapshot.data.email);
          }
        });
  }
}
