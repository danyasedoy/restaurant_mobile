import 'package:app/models/entities/booking_entity.dart';
import 'package:app/models/services/abstract_service.dart';

class BookingService extends AbstractService {
  Future<List<int>?> getAvailableTables(DateTime date) async {
    await apiProvider.getAvailableTablesByDate(date);
    return [1, 2, 5, 8];
  }
  Future<BookingEntity?> getUserBooking() async {
    await apiProvider.getBookingByUser();
    return BookingEntity(1, DateTime.now());
  }
  Future<BookingEntity?> bookTable(DateTime date, int tableNum) async {
    await apiProvider.bookTable(date, tableNum);
    return BookingEntity(tableNum, date);
  }
  Future<bool> cancelBooking() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}