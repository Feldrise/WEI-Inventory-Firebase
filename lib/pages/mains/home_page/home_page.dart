import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory_firebase/provider/user_store.dart';
import 'package:wei_inventory_firebase/shared/widgets/screen_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, @required this.onPush}) : super(key: key);

  final ValueChanged<String> onPush;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ScreenTitle(title: "Bienvenue ${Provider.of<UserStore>(context).firstName}",)
        ],
      ),
    );
  }
}