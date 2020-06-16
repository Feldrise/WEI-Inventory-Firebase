import 'package:flutter/material.dart';
import 'package:wei_inventory_firebase/pages/authentication/forms/login_form.dart';
import 'package:wei_inventory_firebase/shared/widgets/screen_title.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const ScreenTitle(title: "Connexion",),
          Expanded(child: LoginForm())
        ],
      ),
    );
  }

}