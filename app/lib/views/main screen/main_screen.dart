import 'package:app/views/main%20screen/products_screen.dart';
import 'package:app/views/main%20screen/promotion_screen.dart';
import 'package:app/views/main%20screen/shift_screen.dart';
import 'package:flutter/material.dart';
import 'booking_screen.dart';
import 'orders_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.destinationTab, this.roleId});
  final int? destinationTab;
  final int? roleId;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static late List<Widget> _tabOptions;
  static late List<BottomNavigationBarItem> _bottomBarItems;

  @override
  void initState() {
    if (widget.destinationTab != null) _selectedIndex = widget.destinationTab!;
    if (widget.roleId == null || widget.roleId == 0) {
      _tabOptions = <Widget>[
        const BookingScreen(),
        const ProductsScreen(),
        const OrdersScreen(),
        const PromotionScreen()
      ];

      _bottomBarItems = const <BottomNavigationBarItem>[
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
        BottomNavigationBarItem(
          icon: Icon(Icons.featured_play_list_sharp),
          label: 'Новости',
        ),
      ];
    }
    else if (widget.roleId == 1) {
      // экраны официанта
      _tabOptions = <Widget>[
        const ShiftScreen(),
        const ProductsScreen(),
        const OrdersScreen(),
      ];
      _bottomBarItems = const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.tiktok),
          label: 'Смена',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood),
          label: 'Еда',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list),
          label: 'Заказы',
        ),
      ];
    }
    else {
      // экраны курьера
    }
    super.initState();
  }

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
        type: BottomNavigationBarType.fixed,
        items: _bottomBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        onTap: _onItemTapped,
      ),
    );
  }
}



