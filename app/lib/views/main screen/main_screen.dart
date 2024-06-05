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
        builder: (context, viewModel, child) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: const SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TableSelector()
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