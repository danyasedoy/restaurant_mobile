import 'package:app/models/entities/booking_entity.dart';
import 'package:app/models/services/booking_service.dart';
import 'package:app/viewmodels/abstract_viewmodel.dart';
import 'package:flutter/widgets.dart';

class BookingScreenState {
  int? tableNum;
  DateTime? dateTime;
  List<int>? tables;
  BookingEntity? booking;
}

class BookingViewModel extends AbstractViewModel with ChangeNotifier {
  final state = BookingScreenState();
  @override
  final BookingService service = BookingService();

  BookingViewModel() {
    fetchAvailableTables();
  }

  Future<void> fetchAvailableTables() async{
    state.tables = await service.getAvailableTables();
    notifyListeners();
  }

  selectTable(int tableNum) {
    state.tableNum = tableNum;
    notifyListeners();
  }
}