import 'package:app/models/entities/booking_entity.dart';
import 'package:app/models/services/booking_service.dart';
import 'package:app/viewmodels/abstract_viewmodel.dart';
import 'package:flutter/widgets.dart';

class BookingScreenState {
  int? tableNum;
  DateTime? dateTime;
  List<int>? tables;
  BookingEntity? booking;
  bool isBookButtonPressed = false;
  String message = "";
}

class BookingViewModel extends AbstractViewModel with ChangeNotifier {
  final state = BookingScreenState();
  @override
  final BookingService service = BookingService();

  BookingViewModel() {
    fetchBooking();
  }

  Future<void> fetchBooking() async {
    state.isBookButtonPressed = true;
    notifyListeners();

    final booking = await service.getUserBooking();
    if (booking != null) {
      state.booking = booking;
    }

    state.isBookButtonPressed = false;
    notifyListeners();
  }

  Future<void> selectDateTime(DateTime value) async{
    state.dateTime = value;
    fetchAvailableTables();
    notifyListeners();
  }

  Future<void> fetchAvailableTables() async{
    state.tables = await service.getAvailableTables(state.dateTime!);
    notifyListeners();
  }

  selectTable(int tableNum) {
    state.tableNum = tableNum;
    notifyListeners();
  }

  Future<void> bookTable() async{
    state.isBookButtonPressed = true;
    notifyListeners();

    final booking = await service.bookTable(state.dateTime!, state.tableNum!);
    if (booking != null) {
      state.booking = booking;
    }

    state.isBookButtonPressed = false;
    state.message = "Бронирование столика успешно!";
    notifyListeners();
  }

  Future<void> cancelBooking() async {
    state.isBookButtonPressed = true;
    notifyListeners();

    bool response = await service.cancelBooking();
    if (response) {
      state.booking = null;
      state.message = "Бронирование столика отменено";
    }
    else {
      state.message = "Ошибка отмены бронирования";
    }
    state.isBookButtonPressed = false;
    notifyListeners();
  }
}