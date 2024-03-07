import 'package:get/get.dart';

class CartItem {
  final String id;
  final String title;
  final String imageUrl;
  final String dosage;
  final String taking;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.dosage,
    required this.taking,
    this.quantity = 1,
  });
}

class CartController extends GetxController {
  var cartItems = List<CartItem>.empty(growable: true).obs;

  void addItem(
      String id, String title, String imageUrl, String dosage, String taking) {
    int index = cartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      // Item exists, increase quantity
      cartItems[index].quantity++;
    } else {
      // Add new item
      cartItems.add(CartItem(
        id: id,
        title: title,
        imageUrl: imageUrl,
        dosage: dosage,
        taking: taking,
      ));
    }
    cartItems.refresh(); // Update the observable list to refresh UI
  }

  void removeItem(String id) {
    cartItems.removeWhere((item) => item.id == id);
    cartItems.refresh(); // Update the observable list to refresh UI
  }

  void clearCart() {
    cartItems.clear();
    cartItems.refresh(); // Update the observable list to refresh UI
  }
}
