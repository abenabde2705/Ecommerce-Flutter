import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/domain/entities/cart_item.dart';
import 'package:ecommerce_app/presentation/viewmodels/cart_viewmodel.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mon panier")),
      body: Consumer<CartViewModel>(
        builder: (context, vm, _) {
          if (vm.items.isEmpty) {
            return const Center(child: Text("Votre panier est vide"));
          }

          return Column(
            children: [
              // 🛒 Liste des articles
              Expanded(
                child: ListView.builder(
                  itemCount: vm.items.length,
                  itemBuilder: (context, index) {
                    final item = vm.items[index];
                    return _CartItemTile(item: item, vm: vm);
                  },
                ),
              ),

              // 💰 Total + bouton commande
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Total : ${vm.total.toStringAsFixed(2)} €",
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        // 🚧 Checkout sera fait Jour 4
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Commande en cours...")),
                        );
                      },
                      child: const Text("Passer la commande"),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItem item;
  final CartViewModel vm;

  const _CartItemTile({required this.item, required this.vm});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(item.thumbnail, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(item.title),
      subtitle: Text("${item.price.toStringAsFixed(2)} €"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              final newQty = item.quantity - 1;
              if (newQty > 0) {
                vm.updateQuantity(item.productId, newQty);
              } else {
                vm.removeItem(item.productId);
              }
            },
          ),
          Text("${item.quantity}"),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              vm.updateQuantity(item.productId, item.quantity + 1);
            },
          ),
        ],
      ),
    );
  }
}
