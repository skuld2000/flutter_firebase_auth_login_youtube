import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
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
              Text("Don't have an account? Create one."),
              Container(
                height: size.height * 0.05,
              ),
            ],
          ),
        ],
      ),
    );
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
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please input correct Email.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: "Password",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please input correct Password.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    height: _size.height * 0.02,
                  ),
                  Text("Forgot Password"),
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
          child: RaisedButton(
            color: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                print("button pressed!");
              }
            },
            child: Text(
              "Login",
              style: TextStyle(fontSize: 20, color: Colors.white),
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
              backgroundImage: NetworkImage("https://picsum.photos/200"),
            ),
          ),
        ),
      );
}
