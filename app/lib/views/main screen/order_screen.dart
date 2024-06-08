import 'package:app/models/entities/order_entity.dart';
import 'package:app/viewmodels/order_viewmodel.dart';
import 'package:app/views/main%20screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, required this.order});
  final OrderEntity order;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isDelivery = false;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController tableNumberController = TextEditingController();

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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: ListView.separated(
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('К столику'),
                        Switch(
                          value: isDelivery,
                          onChanged: (value) {
                            setState(() {
                              isDelivery = value;
                              widget.order.address = null;
                              widget.order.tableNum = null;
                              tableNumberController.text = "";
                              addressController.text = "";
                            });
                          },
                        ),
                        const Text('Доставка'),
                      ],
                    ),
                    if (isDelivery)
                      TextField(
                        controller: addressController,
                        decoration: const InputDecoration(labelText: 'Адрес доставки'),
                        onChanged: (value) => widget.order.address = value,
                      )
                    else
                      TextField(
                        controller: tableNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Номер столика'),
                        onChanged: (value) => widget.order.tableNum = int.parse(value),
                      ),
                    const SizedBox(height: 20,),
                    if (tableNumberController.text.isNotEmpty || addressController.text.isNotEmpty)
                      ElevatedButton(
                      onPressed: ()=>{
                        viewModel.confirmOrder(widget.order)
                            .then((_) => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const MainScreen(destinationTab: 2,))
                        )
                        )
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.deepOrange),

                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Оформить заказ", style: TextStyle(color: Colors.white),),
                          SizedBox(width: 10, height: 50,),
                          Icon(Icons.check_circle, color: Colors.white,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

