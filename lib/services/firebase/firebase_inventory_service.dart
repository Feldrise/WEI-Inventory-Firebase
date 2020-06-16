import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wei_inventory_firebase/models/inventory.dart';
import 'package:wei_inventory_firebase/models/product.dart';

class FirebaseInventoryService {
  static Stream<QuerySnapshot> inventoriesStream(String userId) {
    return Firestore.instance.collection("users").document(userId).collection("inventories").snapshots();
  }

  static Stream<DocumentSnapshot> inventoryStream(String userId, String inventoryId) {
    return Firestore.instance.collection("users").document(userId).collection("inventories").document(inventoryId).snapshots();
  }
  static Future editInventory(String userId, Inventory toEdit) async {
    await Firestore.instance.collection("users").document(userId).collection("inventories").document(toEdit.id).setData(toEdit.toJson());
  }

  static Future createInventory(String userId, Inventory toCreate) async {
    await Firestore.instance.collection("users").document(userId).collection("inventories").add(toCreate.toJson());
  }

  static Future deleteInventory(String userId, Inventory toDelete) async {
        await Firestore.instance.collection("users").document(userId).collection("inventories").document(toDelete.id).delete();
  }

  static Stream<QuerySnapshot> productsStream(String userId, String inventoryId) {
    return Firestore.instance.collection("users").document(userId).collection("inventories").document(inventoryId).collection("products").snapshots();
  }

  static Future editProduct(String userId, String inventoryId, Product toEdit) async {
    await Firestore.instance.collection("users").document(userId).collection("inventories").document(inventoryId).collection("products").document(toEdit.id).setData(toEdit.toJson());
  }

  static Future createProduct(String userId, String inventoryId, Product toCreate) async {
    await Firestore.instance.collection("users").document(userId).collection("inventories").document(inventoryId).collection("products").add(toCreate.toJson());
  }

  static Future deleteProduct(String userId, String inventoryId, Product toDelete) async {
    await Firestore.instance.collection("users").document(userId).collection("inventories").document(inventoryId).collection("products").document(toDelete.id).delete();
  }
}
