import 'package:ecommerce_app/domain/entities/cart_item.dart';
import 'package:ecommerce_app/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final List<CartItem> _items = [];

  @override
  Future<void> addToCart(CartItem item) async {
    // Vérifie si le produit est déjà dans le panier
    final index = _items.indexWhere((i) => i.productId == item.productId);
    if (index >= 0) {
      // Si déjà présent → augmente la quantité
      final existing = _items[index];
      _items[index] = existing.copyWith(quantity: existing.quantity + item.quantity);
    } else {
      // Sinon → ajoute comme nouveau
      _items.add(item);
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    _items.removeWhere((item) => item.productId == productId);
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    final index = _items.indexWhere((i) => i.productId == productId);
    if (index >= 0) {
      final existing = _items[index];
      _items[index] = existing.copyWith(quantity: quantity);
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    return List.unmodifiable(_items); // on retourne une copie en lecture seule
  }

  @override
  Future<void> clearCart() async {
    _items.clear();
  }
}
