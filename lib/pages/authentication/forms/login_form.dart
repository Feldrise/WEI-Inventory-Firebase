import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wei_inventory_firebase/models/user.dart';
import 'package:wei_inventory_firebase/services/firebase/firebase_user_service.dart';
import 'package:wei_inventory_firebase/shared/widgets/bordered_card.dart';
import 'package:wei_inventory_firebase/shared/widgets/form_text_input.dart';
import 'package:wei_inventory_firebase/utils/colors_utils.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState(); 
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  String _statusMessage = "N'oubliez pas de remplir tous les champs pour vous connecter";
  @override
  Widget build(BuildContext context) {
    final Color inputColor = randomMaterialColor();
    final Color buttonColor = randomMaterialColor();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: BorderedCard(
              color: buttonColor,
              child: Text(_statusMessage),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!_loading) ...{
                      FormTextInput(
                        controller: _emailController,
                        inputType: TextInputType.emailAddress,
                        hintText: "Entrez votre email",
                        labelText: "Email",
                        color: inputColor,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Veuillez rentrer une adresse mail";
                          }

                          return null;
                        },
                      ),
                      FormTextInput(
                        controller: _passwordController,
                        hintText: "Entrez votre mot de passe",
                        labelText: "Mot de Passe",
                        obscureText: true,
                        color: inputColor,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Veuillez rentrer un mot de passe";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 64,),
                      FlatButton(
                        color: buttonColor,
                        onPressed: () async => _login(),
                        child: Text("Se Connecter", style: TextStyle(color: contrastColor(buttonColor)),),
                      )
                    }
                    else 
                      const Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future _login() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _statusMessage = "Connexion en cours...";
      _loading = true;
    });

    try {
      final User loggedUser = await FirebaseUserService.loginUser(_emailController.text, _passwordController.text);

      if (loggedUser != null) {
        Navigator.of(context).pop(loggedUser);
      }
      else {
        setState(() {
          _statusMessage = "Erreur lors de la connexion, vous devez d'abord vérifier votre adresse mail.";
          _loading = false;
        });
      }

    } on PlatformException catch(e) {
      setState(() {
        _statusMessage = "Erreur lors de la connexion : ${e.message}";
        _loading = false;
      });
    }

    _passwordController.clear();
  }
}