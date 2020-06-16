import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory_firebase/models/inventory.dart';
import 'package:wei_inventory_firebase/pages/mains/home_page/widgets/inventory_card.dart';
import 'package:wei_inventory_firebase/provider/user_store.dart';
import 'package:wei_inventory_firebase/services/firebase/firebase_inventory_service.dart';

class InventoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserStore>(
      builder: (context, userStore, child) {
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseInventoryService.inventoriesStream(userStore.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator(),);
            }

            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            final List<Widget> inventoriesWidgets = [];

            for (final DocumentSnapshot inventorySnapshot in snapshot.data.documents) {
              inventoriesWidgets.add(InventoryCard(inventory: Inventory.fromSnapshot(inventorySnapshot),));
            }

            if (inventoriesWidgets.isEmpty) {
              return Container(
                margin: const EdgeInsets.only(bottom: 80),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.assignment, size: 128,),
                    Text("Vous n'avez pas encore d'inventaires.")
                  ],
                )
              );
            }

            return ListView(
              children: inventoriesWidgets.reversed.toList(),
            );
          },
        );
      },
    );
  }
}