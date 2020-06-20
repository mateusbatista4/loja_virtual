import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final User user = User();
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
                : Container()
          ],
          centerTitle: true,
          title: Text('Sign Up'),
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
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Complete Name',
                    ),
                    validator: (name) {
                      if (name.isEmpty)
                        return "Campo obrigatorio";
                      else if (name.trim().split(' ').length == 1)
                        return "Nome Incompleto";
                      else
                        return null;
                    },
                    onSaved: (name) {
                      user.userName = name;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    enabled: !userManager.loading,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                    ),
                    validator: (email) {
                      if (email.isEmpty)
                        return "Campo obrigatorio";
                      else if (!emailValidator(email))
                        return "email inválido";
                      else
                        return null;
                    },
                    onSaved: (email) {
                      user.email = email;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    enabled: !userManager.loading,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (senha) {
                      if (senha.isEmpty)
                        return "Campo obrigatório";
                      else if (senha.length < 6)
                        return 'Senha muito curta';
                      else if (senha != _password2Controller.text)
                        return 'As senhas devem ser iguais';
                      else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    enabled: !userManager.loading,
                    controller: _password2Controller,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Comfirm password',
                    ),
                    validator: (senha) {
                      if (senha.isEmpty)
                        return "Campo obrigatório";
                      else if (senha.length < 6)
                        return 'Senha muito curta';
                      else if (senha != _passwordController.text)
                        return 'As senhas devem ser iguais';
                      else
                        return null;
                    },
                    onSaved: (pass) {
                      user.password = pass;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 45,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          context.read<UserManager>().signUp(
                                user: user,
                                onSuccess: () {
                                  Navigator.of(context).pop();
                                },
                                onFail: (erro) {
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text('Falha no registro: $erro'),
                                    ),
                                  );
                                },
                              );
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Registrar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
