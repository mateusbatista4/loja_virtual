import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: Center(
          child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
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
                  if (!emailValidator(email)) return "Email inválido";
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
                    return "A senha não pde seer nula";
                  else if (senha.length < 6) return "A senha muito curta";
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
                      if (formKey.currentState.validate()) {}
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
