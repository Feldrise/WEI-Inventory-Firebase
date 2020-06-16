import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory_firebase/pages/mains/home_page/widgets/inventories_list.dart';
import 'package:wei_inventory_firebase/provider/user_store.dart';
import 'package:wei_inventory_firebase/shared/dialogs/edit_inventory_dialog.dart';
import 'package:wei_inventory_firebase/shared/widgets/screen_title.dart';
import 'package:wei_inventory_firebase/utils/colors_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, @required this.onPush}) : super(key: key);

  final ValueChanged<String> onPush;

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = randomMaterialColor();

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: ScreenTitle(title: "Bienvenue ${Provider.of<UserStore>(context).firstName}",)
              ),
              Expanded(
                child: InventoriesList(),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 0,
            child:  Container(
              width: 64,
              height: 64,
              color: buttonColor,
              child: FlatButton(
                onPressed: () async => _addInventory(context),
                color: buttonColor,
                child: Icon(Icons.add, color: contrastColor(buttonColor),),
              ),
            )
          )
        ]
      ),
    );
  }

  Future _addInventory(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context, 
      builder: (context) => const EditInventoryDialog()
    );
  }
}