import 'dart:convert';

import 'package:app/models/entities/booking_entity.dart';
import 'package:app/models/services/abstract_service.dart';
import 'package:intl/intl.dart';

class BookingService extends AbstractService {
  Future<List<int>?> getAvailableTables(DateTime date) async {
    final token = await storageProvider.loadToken();
    final response = await apiProvider.getAvailableTablesByDate(token!, date);
    final tempList = jsonDecode(response.body) as List; // Cast to List<dynamic>
    return tempList.map((e) => e as int).toList();
  }
  Future<BookingEntity?> getUserBooking() async {
    final token = await storageProvider.loadToken();
    final response = await apiProvider.getBookingByUser(token!);
    if (jsonDecode(response.body) == null) {
      return null;
    }
    return BookingEntity(
        jsonDecode(response.body)["table"],
        DateFormat('dd.MM.yyyy').parse(jsonDecode(response.body)['date'])
    );
  }
  Future<BookingEntity?> bookTable(DateTime date, int tableNum) async {
    final token = await storageProvider.loadToken();
    var response = await apiProvider.bookTable(token!, date, tableNum);
    if (response.statusCode == 200) {
      return BookingEntity(tableNum, date);
    }
    return null;
  }
  Future<bool> cancelBooking() async {
    final token = await storageProvider.loadToken();
    var response = await apiProvider.cancelBooking(token!);
    return response.statusCode == 200;
  }
}