import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory_firebase/models/product.dart';
import 'package:wei_inventory_firebase/provider/user_store.dart';
import 'package:wei_inventory_firebase/services/firebase/firebase_inventory_service.dart';
import 'package:wei_inventory_firebase/shared/widgets/form_text_input.dart';
import 'package:wei_inventory_firebase/utils/colors_utils.dart';

class EditProductDialog extends StatefulWidget {
  const EditProductDialog({Key key, @required this.inventoryId, this.product}) : super(key: key);

  final String inventoryId;
  final Product product;

  @override
  _EditProductDialogState createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Product _product;

  @override
  void initState() {
    super.initState();

    _product = widget.product;

    if (_product != null) {
      _quantityController.text = _product.quantity.toString();
      _nameController.text = _product.name;
      _descriptionController.text = _product.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color formColor = randomMaterialColor();

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0, top: 32.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Information sur le produit", style: Theme.of(context).textTheme.headline1,),
            FormTextInput(
              controller: _quantityController,
              inputType: TextInputType.number,
              hintText: "Entrez le nombre d'item en stock",
              labelText: "Quantité",
              color: formColor,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Vous devez renseigner la quantité";
                }

                final int quantity = num.tryParse(value).toInt();

                if (quantity < 1) {
                  return "Vous devez avoir au moins un item en stock.";
                }

                return null;
              },
            ),
            FormTextInput(
              controller: _nameController,
              hintText: "Entrez le noom du produit",
              labelText: "Nom",
              color: formColor,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Le produit doit avoir un nom";
                }

                return null;
              },
            ),
            FormTextInput(
              controller: _descriptionController,
              hintText: "Entrez la description du produit",
              labelText: "Description",
              inputType: TextInputType.multiline,
              color: formColor,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Le produit doit avoir une description";
                }

                return null;
              },
            ),
            const SizedBox(height: 32,),
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
                    onPressed: _validate,
                    color: formColor,
                    child: Text("Valider", style: Theme.of(context).textTheme.button.merge(TextStyle(color: contrastColor(formColor))),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _validate() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    if (_product == null) {
      await _createProduct();
    }
    else {
      await _editProduct();
    }
    
    Navigator.of(context).pop();
  }

  Future _createProduct() async {
    final String userId = Provider.of<UserStore>(context, listen: false).id;

    FirebaseInventoryService.createProduct(userId, widget.inventoryId, Product(
      null,
      quantity: num.tryParse(_quantityController.text).toInt(),
      name: _nameController.text,
      description: _descriptionController.text
    ));
    
  }

  Future _editProduct() async {
    final String userId = Provider.of<UserStore>(context, listen: false).id;

    _product.quantity = num.tryParse(_quantityController.text).toInt();
    _product.name = _nameController.text;
    _product.description = _descriptionController.text;

    FirebaseInventoryService.editProduct(userId, widget.inventoryId, _product);
  }
}