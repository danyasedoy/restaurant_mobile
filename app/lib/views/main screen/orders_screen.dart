import 'package:app/models/entities/order_entity.dart';
import 'package:app/viewmodels/orders_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_screen.dart';


class OrdersScreen extends StatefulWidget {

  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrdersListViewModel(),
      child: Consumer<OrdersListViewModel>(
        builder: (context, viewModel, child) {
          return Stack(
            children: [
              const OrdersListBuilder(),
              Positioned(
                bottom: 32.0,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: viewModel.refreshScreen,
                  child: const Icon(Icons.refresh, color: Colors.white,),
                ),
              ),
            ]
          );
        }
      ),
    );
  }
}

class OrdersListBuilder extends StatelessWidget {
  const OrdersListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<OrdersListViewModel>();
    context.select((OrdersListViewModel vm) => vm.refreshFlag);
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
                  onTap:  () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OrderScreen(order: order))),
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
                  onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OrderScreen(order: order))),
                );
              }
            }
          );
        }
      }
    );
  }
}


