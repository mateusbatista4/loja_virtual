import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<UserManager>(
      builder: (context, userManager, child) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          actions: <Widget>[
            userManager.loading
                ? Container(
                    margin: EdgeInsets.only(right: 15, top: 10, bottom: 10),
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white)),
                  )
                : RaisedButton(
                    elevation: 0,
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/signup');
                    })
          ],
          centerTitle: true,
          title: Text("Login"),
        ),
        body: Center(
            child: Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(18),
              shrinkWrap: true,
              children: <Widget>[
                TextFormField(
                  enabled: !userManager.loading,
                  controller: emailController,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (email) {
                    if (!emailValidator(email))
                      return "Email inválido";
                    else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  enabled: !userManager.loading,
                  controller: passwordController,
                  decoration: InputDecoration(hintText: "Senha"),
                  obscureText: true,
                  autocorrect: false,
                  validator: (senha) {
                    if (senha.isEmpty)
                      return "A senha não pde ser nula";
                    else if (senha.length < 6)
                      return "A senha muito curta";
                    else
                      return null;
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Text(
                      "Esqueci minha senha",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 45,
                  child: RaisedButton(
                    onPressed: userManager.loading
                        ? null
                        : () {
                            if (_formKey.currentState.validate()) {
                              userManager.signIn(
                                onSuccess: () {
                                  //  TODO: FECHAR LOGIN
                                  Navigator.of(context).pop();
                                },
                                onFail: (erro) {
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text('Falha no Login: $erro'),
                                    ),
                                  );
                                },
                                user: User(
                                    email: emailController.text,
                                    password: passwordController.text),
                              );
                            }
                          },
                    color: Theme.of(context).primaryColor,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    child: Text("Entrar"),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
