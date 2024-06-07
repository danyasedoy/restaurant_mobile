import 'package:app/models/entities/order_entity.dart';
import 'package:app/viewmodels/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, required this.order});
  final OrderEntity order;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderViewModel(),
      child: Consumer<OrderViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Ваш заказ",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => {
                    viewModel.saveOrder(order: widget.order),
                    Navigator.pushReplacementNamed(context, '/main')
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.transparent)
                  ),
                  child: const Text("К меню",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                )
              ],
              centerTitle: true,
              backgroundColor: Colors.deepOrange,
            ),
            body: Stack(
                children: [
                  ListView.separated(
                      itemBuilder: (context, index) {
                        final product = widget.order.products[index];
                        return ListTile(
                          title: Text(product.name),
                          trailing: Text('${product.price} руб.'),
                          subtitle: Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      product.count-=1;
                                      if (product.count <= 0) {
                                        widget.order.products.removeAt(index);
                                      }
                                    });
                                  },
                                  child: const Icon(Icons.exposure_minus_1)),
                              Text("${product.count}"),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      product.count+=1;
                                    });
                                  },
                                  child: const Icon(Icons.plus_one)),
                            ],
                          ),
                        );
                      },
                      separatorBuilder:(context, index) => const Divider(),
                      itemCount: widget.order.products.length
                  ),
                  Positioned(
                    bottom: 32.0,
                    right: 16.0,
                    child: ElevatedButton(
                      onPressed: ()=>{viewModel.confirmOrder(widget.order)},
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.deepOrange)
                      ),
                      child: const Row(
                        children: [
                          Text("Оформить заказ", style: TextStyle(color: Colors.white),),
                          SizedBox(width: 10, height: 50,),
                          Icon(Icons.check_circle, color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                ]
            ),
          );
        }
      ),
    );
  }
}

