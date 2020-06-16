import 'package:flutter/material.dart';

class DeleteInventoryConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Suppression"),
      content: const Text("Voulez vous vraiment supprimer cet inventaire ?"),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Non"),
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("Oui", style: TextStyle(color: Colors.red),),
        )
      ],
    );
  }

}