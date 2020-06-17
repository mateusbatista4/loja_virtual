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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
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
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        context.read<UserManager>().signIn(
                            onSuccess: () {
                              //  TODO: FECHAR LOGIN
                            },
                            onFail: (erro) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Text('Falha no Login: $erro'),
                              ));
                            },
                            user: User(
                                email: emailController.text,
                                password: passwordController.text));
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text("Entrar")),
              )
            ],
          ),
        ),
      )),
    );
  }
}
