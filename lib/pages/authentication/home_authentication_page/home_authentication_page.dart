import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory_firebase/models/user.dart';
import 'package:wei_inventory_firebase/pages/authentication/login_page/login_page.dart';
import 'package:wei_inventory_firebase/pages/authentication/register_page/register_page.dart';
import 'package:wei_inventory_firebase/provider/user_store.dart';
import 'package:wei_inventory_firebase/utils/colors_utils.dart';

class HomeAuthenticationPage extends StatelessWidget {
  const HomeAuthenticationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginButtonColor = randomMaterialColor();
    final registerButtonColor = randomMaterialColor();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: FlatButton(
                        onPressed: () async => _loginClicked(context),
                        color: loginButtonColor,
                        child: Text("Connexion", style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: contrastColor(loginButtonColor))),),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: FlatButton(
                        onPressed: () => _registerClicked(context),
                        color: registerButtonColor,
                        child: Text("Inscription", style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: contrastColor(registerButtonColor))),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _registerClicked(BuildContext context) {
    Navigator.push<void>(
      context, 
      MaterialPageRoute(
        builder: (context) => RegisterPage()
      )
    );
  }

  Future _loginClicked(BuildContext context) async {
    final User loggedUser = await Navigator.push<User>(
      context, 
      MaterialPageRoute(
        builder: (context) => LoginPage()
      )
    );

    if (loggedUser != null) {
      Provider.of<UserStore>(context, listen: false).userLogged(loggedUser);
    }
  }
}