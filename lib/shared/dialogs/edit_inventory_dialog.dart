import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory_firebase/models/inventory.dart';
import 'package:wei_inventory_firebase/provider/user_store.dart';
import 'package:wei_inventory_firebase/services/firebase/firebase_inventory_service.dart';
import 'package:wei_inventory_firebase/shared/widgets/form_text_input.dart';
import 'package:wei_inventory_firebase/utils/colors_utils.dart';

class EditInventoryDialog extends StatefulWidget {
  const EditInventoryDialog({Key key, this.inventory}) : super(key: key);

  final Inventory inventory;

  @override
  _EditInventoryDialogState createState() => _EditInventoryDialogState();
}

class _EditInventoryDialogState extends State<EditInventoryDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Inventory _inventory;

  @override
  void initState() {
    super.initState();

    _inventory = widget.inventory;

    if (_inventory != null) {
      _nameController.text = _inventory.name;
      _descriptionController.text = _inventory.description;
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
            Text("Information sur l'inventaire", style: Theme.of(context).textTheme.headline1,),
            FormTextInput(
              controller: _nameController,
              hintText: "Entrez le noom de l'inventaire",
              labelText: "Nom",
              color: formColor,
              validator: (String value) {
                if (value.isEmpty) {
                  return "L'inventaire doit avoir un nom";
                }

                return null;
              },
            ),
            FormTextInput(
              controller: _descriptionController,
              hintText: "Entrez la description de l'inventaire",
              labelText: "Description",
              inputType: TextInputType.multiline,
              color: formColor,
              validator: (String value) {
                if (value.isEmpty) {
                  return "L'inventaire doit avoir une description";
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

    if (_inventory == null) {
      await _createInventory();
    }
    else {
      await _editInventory();
    }
    
    Navigator.of(context).pop();
  }

  Future _createInventory() async {
    final String userId = Provider.of<UserStore>(context, listen: false).id;

    FirebaseInventoryService.createInventory(userId, Inventory(
      null,
      name: _nameController.text,
      description: _descriptionController.text
    ));
    
  }

  Future _editInventory() async {
    final String userId = Provider.of<UserStore>(context, listen: false).id;

    _inventory.name = _nameController.text;
    _inventory.description = _descriptionController.text;

    FirebaseInventoryService.editInventory(userId, _inventory);
  }
}