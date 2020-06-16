import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory_firebase/models/product.dart';
import 'package:wei_inventory_firebase/provider/user_store.dart';
import 'package:wei_inventory_firebase/services/firebase/firebase_inventory_service.dart';

class ViewProductDialog extends StatelessWidget {
  const ViewProductDialog({Key key, this.inventoryId, @required this.product}) : super(key: key);

  final String inventoryId;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0, top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(product.name, style: Theme.of(context).textTheme.headline1,),
          const SizedBox(height: 16,),
          Text("Quantité en stock : ${product.quantity}", style: const TextStyle(fontStyle: FontStyle.italic),),
          const SizedBox(height: 16,),
          Text(product.description),
          Expanded(child: Container(),),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  color: Colors.grey[300],
                  child: Text("Annuler", style: Theme.of(context).textTheme.button),
                ),
                const SizedBox(width: 8,),
                FlatButton(
                  onPressed: () async => _deleteProduct(context),
                  color: Colors.red,
                  child: Text("Supprimer", style: Theme.of(context).textTheme.button.merge(const TextStyle(color: Colors.white)),),
                )
              ],
            ),
          )
        ],
      )
    );
  }

  Future _deleteProduct(BuildContext context) async {
    final String userId = Provider.of<UserStore>(context, listen: false).id;
    
    await FirebaseInventoryService.deleteProduct(userId, inventoryId, product);

    Navigator.of(context).pop();
  }
}