import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory_firebase/models/product.dart';
import 'package:wei_inventory_firebase/pages/mains/inventory_page/widgets/product_card.dart';
import 'package:wei_inventory_firebase/provider/user_store.dart';
import 'package:wei_inventory_firebase/services/firebase/firebase_inventory_service.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({Key key, @required this.inventoryId}) : super(key: key);

  final String inventoryId;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserStore>(
      builder: (context, userStore, child) {
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseInventoryService.productsStream(userStore.id, inventoryId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator(),);
            }

            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            final List<Widget> productsWidget = [];

            for (final DocumentSnapshot productSnapshot in snapshot.data.documents) {
              productsWidget.add(ProductCard(product: Product.fromSnapshot(productSnapshot), inventoryId: inventoryId,));
            }

            if (productsWidget.isEmpty) {
              return Container(
                margin: const EdgeInsets.only(bottom: 80),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.face, size: 128,),
                    Text("Cet inventaire est vide.")
                  ],
                )
              );
            }

            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 6 / 7
              ),
              children: productsWidget.reversed.toList(),
            );
          },
        );
      },
    );
  }

}