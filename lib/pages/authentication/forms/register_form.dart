import 'package:flutter/material.dart';
import 'package:wei_inventory_firebase/models/user.dart';
import 'package:wei_inventory_firebase/services/firebase/firebase_user_service.dart';
import 'package:wei_inventory_firebase/shared/widgets/bordered_card.dart';
import 'package:wei_inventory_firebase/shared/widgets/form_text_input.dart';
import 'package:wei_inventory_firebase/utils/colors_utils.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState(); 
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  String _statusMessage = "N'oubliez pas de remplir tous les champs pour vous inscrire";
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
                        controller: _firstNameController,
                        hintText: "Entrez votre Prénom",
                        labelText: "Prénom",
                        color: inputColor,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Veuillez rentrer un prénom";
                          }

                          return null;
                        },
                      ),
                      FormTextInput(
                        controller: _secondNameController,
                        hintText: "Entrez votre Nom",
                        labelText: "Nom",
                        color: inputColor,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Veuillez rentrer un nom";
                          }

                          return null;
                        },
                      ),
                      FormTextInput(
                        controller: _passwordController,
                        hintText: "Entrez votre mot de passe",
                        labelText: "Mot de Passe",
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
                        onPressed: () async => _register(),
                        child: Text("S'inscrire", style: TextStyle(color: contrastColor(buttonColor)),),
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

  Future _register() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _statusMessage = "Inscription en cours...";
      _loading = true;
    });

    final User toRegister = User(
      firstName: _firstNameController.text,
      secondName: _secondNameController.text,
      email: _emailController.text
    );

    final bool sucess = await FirebaseUserService.registerUser(toRegister, _passwordController.text);

    setState(() {
      if (sucess) {
        _statusMessage = "Vous avez bien été enregistrez. Confirmez votre adresse mail pour pouvoir vous connecter.";
      }
      else {
        _statusMessage = "Une erreur est survenue... Vérifiez que l'adresse e-mail n'est pas utilisez. Si l'erreur persiste, veuillez nous contacter.";
      }

      _loading = false;
    });

    _firstNameController.clear();
    _secondNameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }
}