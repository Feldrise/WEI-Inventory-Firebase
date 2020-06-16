import 'package:flutter/material.dart';
import 'package:wei_inventory_firebase/pages/authentication/forms/register_form.dart';
import 'package:wei_inventory_firebase/shared/widgets/screen_title.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const ScreenTitle(title: "Inscription",),
          Expanded(child: RegisterForm())
        ],
      ),
    );
  }

}