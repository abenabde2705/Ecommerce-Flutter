import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<void> addToCart(CartItem item);
  Future<void> removeFromCart(int productId);
  Future<void> updateQuantity(int productId, int quantity);
  Future<List<CartItem>> getCartItems();
  Future<void> clearCart();
}
