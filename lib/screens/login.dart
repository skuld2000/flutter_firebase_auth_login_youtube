import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_login_youtube/data/join_or_login.dart';
import 'package:flutter_firebase_auth_login_youtube/helper/loginbackground.dart';
import 'package:provider/provider.dart';

import '../data/join_or_login.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Initialize FlutterFire
    Firebase.initializeApp();

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            painter:
                LoginBackground(isJoin: context.watch<JoinOrLogin>().isJoin),
            //isJoin: Provider.of<JoinOrLogin>(context).isJoin),
            size: size,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _logoImage,
              Stack(children: <Widget>[
                _inputForm(size),
                _authButton(size),
              ]),
              Container(
                height: size.height * 0.1,
              ),
              GestureDetector(
                onTap: () {
                  //Provider.of<JoinOrLogin>(context, listen: false).toggle();
                  context.read<JoinOrLogin>().toggle();
                },
                child: Text(
                  context.watch<JoinOrLogin>().isJoin
                      ? "Already have an account? Sign in"
                      : "Don't have an account? Create one",
                  style: TextStyle(
                      color: context.watch<JoinOrLogin>().isJoin
                          ? Colors.red
                          : Colors.blue),
                ),
              ),
              Container(
                height: size.height * 0.05,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _register(BuildContext context) async {
    final UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final User user = result.user;

    if (user == null) {
      final snacBar = SnackBar(
        content: Text('Please try again later'),
      );
      Scaffold.of(context).showSnackBar(snacBar);
    }

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => MainPage(
    //               email: user.email,
    //             )));
  }

  void _login(BuildContext context) async {
    final UserCredential result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final User user = result.user;

    if (user == null) {
      final snacBar = SnackBar(
        content: Text('Please try again later'),
      );
      Scaffold.of(context).showSnackBar(snacBar);
    }
  }

  Widget _inputForm(Size _size) => Padding(
        padding: EdgeInsets.all(_size.width * 0.05),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 35),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.account_circle),
                        labelText: "Email",
                        hintText: "you@example.com"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please input correct Email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        labelText: "Password",
                        hintText: "6 characters or more"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please input correct Password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    height: _size.height * 0.02,
                  ),
                  Consumer<JoinOrLogin>(
                    builder: (context, joinOrLogin, child) => Opacity(
                      opacity: joinOrLogin.isJoin ? 0 : 1,
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  // Container(
  //   width: 100,
  //   height: 50,
  //   color: Colors.black,
  // ),

  Widget _authButton(Size _size) => Positioned(
        left: _size.width * 0.15,
        right: _size.width * 0.15,
        bottom: 0,
        child: SizedBox(
          height: 50,
          child: Consumer<JoinOrLogin>(
            builder: (context, joinOrLogin, child) => RaisedButton(
              color: joinOrLogin.isJoin ? Colors.red : Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  joinOrLogin.isJoin ? _register(context) : _login(context);
                }
              },
              child: Text(
                joinOrLogin.isJoin ? "Join" : "Login",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      );

  Widget get _logoImage => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              //backgroundImage: NetworkImage("https://picsum.photos/200"),
              backgroundImage: AssetImage("assets/login.gif"),
            ),
          ),
        ),
      );
}
