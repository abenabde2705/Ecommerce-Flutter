import 'package:flutter/foundation.dart';
import 'package:ecommerce_app/domain/entities/cart_item.dart';
import 'package:ecommerce_app/domain/repositories/cart_repository.dart';

class CartViewModel extends ChangeNotifier {
  final CartRepository repository;

  List<CartItem> _items = [];
  List<CartItem> get items => List.unmodifiable(_items);

  CartViewModel({required this.repository});

  // ⚡ Charger les articles depuis le repo
  Future<void> loadCart() async {
    _items = await repository.getCartItems();
    notifyListeners();
  }

  // ⚡ Ajouter au panier
  Future<void> addItem(CartItem item) async {
    await repository.addToCart(item);
    await loadCart(); // recharge après modification
  }

  // ⚡ Supprimer un produit
  Future<void> removeItem(int productId) async {
    await repository.removeFromCart(productId);
    await loadCart();
  }

  // ⚡ Modifier la quantité
  Future<void> updateQuantity(int productId, int quantity) async {
    await repository.updateQuantity(productId, quantity);
    await loadCart();
  }

  // ⚡ Vider le panier
  Future<void> clear() async {
    await repository.clearCart();
    await loadCart();
  }

  // ⚡ Total du panier
  double get total {
    return _items.fold(0, (sum, item) => sum + item.price * item.quantity);
  }
}
