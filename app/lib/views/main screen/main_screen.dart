import 'package:app/viewmodels/booking_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _tabOptions = <Widget>[
    BookingScreen(),
    ProductsScreen(),
    OrdersScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '❤️Хрючево❤️',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: _tabOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Бронирование',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Еда',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'Заказы',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        onTap: _onItemTapped,
      ),
    );
  }
}

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingViewModel(),
      child: Consumer<BookingViewModel>(
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
          if (viewModel.state.isBookButtonPressed) {
            return const CircularProgressIndicator();
          }
          else if (viewModel.state.booking != null) {
            return Center(
              child: Card(
                elevation: 20,
                shadowColor: Colors.deepOrange,
                color: Colors.white,
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.check_circle, color: Colors.deepOrange, size: 40),
                      const Text("Вы забронировали столик!", style: TextStyle(fontSize: 20),),
                      Text("Дата: ${viewModel.state.booking!.dateTime.toString().substring(0,10)}", style: const TextStyle(fontSize: 20),),
                      Text("Номер столика: №${viewModel.state.booking!.tableNum}", style: const TextStyle(fontSize: 20),),
                      ElevatedButton(
                        onPressed: viewModel.cancelBooking,
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.redAccent)
                        ),
                        child: const Text(
                          "Отменить",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          else {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Дата бронирования"),
                      const DatePicker(),
                      const SizedBox( height: 50,),
                      if (viewModel.state.dateTime != null) const TableSelector(),
                      const SizedBox( height: 50,),
                      if (viewModel.state.tableNum != null)
                        SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: viewModel.bookTable,
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(Colors.deepOrange)
                            ),
                            child: const Text(
                              "Забронировать",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            );
          }
        }
      ),
    );
  }
}

class TableSelector extends StatelessWidget {
  const TableSelector({super.key});
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BookingViewModel>(context);
    final state = viewModel.state;

    if (state.tables == null) {
      return const CircularProgressIndicator();
    }
    else if (state.tables!.isEmpty) {
      return const Text('Нет доступных столов');
    }
    else {
      return DropdownButtonFormField<int>(
        decoration: const InputDecoration(labelText: 'Выберите столик'),
        value: state.tableNum,
        onChanged: (tableNum) => viewModel.selectTable(tableNum!),
        items: state.tables!.map((tableNum) {
          return DropdownMenuItem<int>(
            value: tableNum,
            child: Text('Столик №$tableNum'),
          );
        }).toList(),
      );
    }
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  Future<void> _selectDate(BuildContext context) async {
    final viewModel = Provider.of<BookingViewModel>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: viewModel.state.dateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != viewModel.state.dateTime) {
      viewModel.selectDateTime(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BookingViewModel>(context);
    final state = viewModel.state;

    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: () => _selectDate(context),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.deepOrange)
        ),
        child: Text(
            state.dateTime != null
            ? viewModel.state.dateTime.toString().substring(0,10)
            : 'Выберите дату',
          style: const TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}













class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Менюшка'));
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Заказы'));
  }
}