import 'package:app/models/entities/product_entity.dart';
import 'package:app/viewmodels/order_viewmodel.dart';
import 'package:app/views/main%20screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderViewModel(),
      child: Consumer<OrderViewModel> (
        builder: (context, viewModel, child)
        {
          if (viewModel.state.message.isNotEmpty) {
            final message = viewModel.state.message;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message, style: const TextStyle(color: Colors.white),)),
              );
            });
            viewModel.state.message = "";
          }
          return Stack(
            children: [
              const ProductsList(),
              if (viewModel.state.order != null)
                Positioned(
                  bottom: 32.0,
                  right: 16.0,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => OrderScreen(order: viewModel.state.order!))
                      );
                    },
                    child: const Icon(Icons.shopping_cart, color: Colors.white,),
                  ),
                ),
            ]
          );
        }
      ),
    );
  }
}

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OrderViewModel>(context, listen: false);

    return FutureBuilder<List<ProductEntity>>(
        future: viewModel.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }
          else if (snapshot.hasData) {
            final products = snapshot.data!;
            return ListView.separated(
              itemCount: products.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  trailing: Text('${product.price} руб.'),
                  onTap: () => viewModel.addProductToOrder(product),
                );
              },
            );
          } else {
            return const Center(child: Text('Нет данных'));
          }
        }
    );
  }
}
