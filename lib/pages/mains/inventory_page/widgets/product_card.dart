import 'package:flutter/material.dart';
import 'package:wei_inventory_firebase/models/product.dart';
import 'package:wei_inventory_firebase/shared/dialogs/edit_product_dialog.dart';
import 'package:wei_inventory_firebase/shared/dialogs/view_product_dialog.dart';
import 'package:wei_inventory_firebase/shared/widgets/bordered_card.dart';
import 'package:wei_inventory_firebase/utils/colors_utils.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key key, this.inventoryId, this.product}) : super(key: key);

  final String inventoryId;
  final Product product;

  @override
  Widget build(BuildContext context) {
    final Color productColor = randomMaterialColor();

    return BorderedCard(
      color: productColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(product.name, style: Theme.of(context).textTheme.headline2,),
          const SizedBox(height: 8.0,),
          Expanded(
            child: Text(product.description, overflow: TextOverflow.ellipsis, maxLines: 3,),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              ClipOval(
                child: Material(
                  color: Colors.white, // button color
                  child: InkWell(
                    splashColor: productColor, // inkwell color
                    onTap: () async => _editProduct(context),
                    child: const SizedBox(width: 48, height: 48, child: Icon(Icons.edit)),
                  ),
                ),
              ),
              ClipOval(
                child: Material(
                  color: Colors.white, // button color
                  child: InkWell(
                    splashColor: productColor, // inkwell color
                    onTap: () async => _viewProduct(context),
                    child: const SizedBox(width: 48, height: 48, child: Icon(Icons.remove_red_eye)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future _viewProduct(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context, 
      builder: (context) => ViewProductDialog(product: product, inventoryId: inventoryId,),
    );
  }
  
  Future _editProduct(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context, 
      builder: (context) => EditProductDialog(product: product, inventoryId: inventoryId,),
    );
  }
}