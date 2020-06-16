import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory_firebase/models/inventory.dart';
import 'package:wei_inventory_firebase/pages/mains/inventory_page/dialogs/delete_inventory_confirmation.dart';
import 'package:wei_inventory_firebase/pages/mains/inventory_page/widgets/products_list.dart';
import 'package:wei_inventory_firebase/provider/user_store.dart';
import 'package:wei_inventory_firebase/services/firebase/firebase_inventory_service.dart';
import 'package:wei_inventory_firebase/shared/dialogs/edit_inventory_dialog.dart';
import 'package:wei_inventory_firebase/shared/dialogs/edit_product_dialog.dart';
import 'package:wei_inventory_firebase/shared/widgets/screen_title.dart';
import 'package:wei_inventory_firebase/utils/colors_utils.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key key, @required this.inventoryId}) : super(key: key);

  final String inventoryId;

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = randomMaterialColor();

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseInventoryService.inventoryStream(Provider.of<UserStore>(context).id, inventoryId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(),);
        } 

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()),);
        }

        final Inventory inventory = Inventory.fromSnapshot(snapshot.data);

        return Scaffold(
          appBar: AppBar(),
          body: Stack(
            children: [
              Column(
                children: [
                  ScreenTitle(title: inventory.name),
                  Text(inventory.description, textAlign: TextAlign.center,),
                  const SizedBox(height: 16.0,),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      ClipOval(
                        child: Material(
                          color: buttonColor, // button color
                          child: InkWell(
                            splashColor: Colors.red,
                            onTap: () async => _updateInventory(context, inventory), // inkwell color
                            child: SizedBox(width: 48, height: 48, child: Icon(Icons.edit, color: contrastColor(buttonColor),)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      ClipOval(
                        child: Material(
                          color: Colors.red, // button color
                          child: InkWell(
                            splashColor: buttonColor,
                            onTap: () async => _deleteInventory(context, inventory), // inkwell color
                            child: const SizedBox(width: 48, height: 48, child: Icon(Icons.delete, color: Colors.white),)),
                          ),
                        ),
                    ],
                  ),
                  Expanded(
                    child: ProductsList(inventoryId: inventoryId,),
                  ),
                ],
              ),
              Positioned(
                bottom: 16,
                right: 0,
                child: Container(
                  width: 64,
                  height: 64,
                  color: buttonColor,
                  child: FlatButton(
                    onPressed: () async => _addProduct(context),
                    color: buttonColor,
                    child: Icon(Icons.add, color: contrastColor(buttonColor),),
                  ),
                ),
              )
            ]
          ),
        ); 
      },
    );
  }

  Future _addProduct(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context, 
      builder: (context) => EditProductDialog(inventoryId: inventoryId,)
    );
  }

  Future _updateInventory(BuildContext context, Inventory inventory) async {
    await showModalBottomSheet<void>(
      context: context, 
      builder: (context) => EditInventoryDialog(inventory: inventory,)
    );
  }

  Future _deleteInventory(BuildContext context, Inventory inventory) async {
    final String userId = Provider.of<UserStore>(context, listen: false).id;

    final bool delete = await showDialog(
      context: context,
      builder: (context) => DeleteInventoryConfirmation()
    );

    if (delete) {
      await FirebaseInventoryService.deleteInventory(userId, inventory);
    
      Navigator.of(context).pop();
    }
  }
}