import 'package:app/viewmodels/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderViewModel(),
      child: Consumer<OrderViewModel>(
        builder: (context, viewModel, child) {
          return const Placeholder();
        },
      ),
    );
  }
}
