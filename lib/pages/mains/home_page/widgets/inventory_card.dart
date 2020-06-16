import 'package:flutter/material.dart';
import 'package:wei_inventory_firebase/models/inventory.dart';
import 'package:wei_inventory_firebase/pages/mains/inventory_page/inventory_page.dart';
import 'package:wei_inventory_firebase/shared/dialogs/edit_inventory_dialog.dart';
import 'package:wei_inventory_firebase/shared/widgets/bordered_card.dart';

class InventoryCard extends StatelessWidget {
  const InventoryCard({Key key, @required this.inventory}) : super(key: key);

  final Inventory inventory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => _openInvenory(context),
      child: BorderedCard(
        borderSide: CardBorderSide.left,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(inventory.name, style: Theme.of(context).textTheme.headline2,),
                  const SizedBox(height: 8),
                  Text(inventory.description, style: Theme.of(context).textTheme.bodyText2,)
                ],
              ),
            ),
            FlatButton(
              onPressed: () async => _editInventory(context),
              child: const Icon(Icons.edit),
            )
          ],
        ),
      ),
    );
  }

  Future _openInvenory(BuildContext context) async {
    await Navigator.push<void>(
      context, 
      MaterialPageRoute(builder: (context) => InventoryPage(inventoryId: inventory.id,))
    );
  }

  Future _editInventory(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context, 
      builder: (context) => EditInventoryDialog(inventory: inventory,)
    );
  }
}