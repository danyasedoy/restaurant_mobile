import 'package:app/models/entities/order_entity.dart';
import 'package:app/viewmodels/orders_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrdersListViewModel(),
      child: Consumer<OrdersListViewModel>(
        builder: (context, viewModel, child) {
          return FutureBuilder(
            future: viewModel.fetchOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              }
              else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Заказов пока нет'));
              }
              else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final order = snapshot.data![index];
                    if (order.address != null) {
                      return ListTile(
                        title: Text('Заказ №${order.id}'),
                        subtitle: Text(order.dateTime.toString().substring(0, 16)),
                        trailing: SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(order.status.statusString),
                              Text(order.address!, overflow: TextOverflow.ellipsis, maxLines: 2,),
                            ],
                          )
                        ),
                      );
                    }
                    else {
                      return ListTile(
                        title: Text('Заказ №${order.id}'),
                        subtitle: Text(order.dateTime.toString().substring(0, 16)),
                        trailing: SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(order.status.statusString),
                              Text("Столик №${order.tableNum}"),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                );
              }
            }
          );
        }
      ),
    );
  }
}