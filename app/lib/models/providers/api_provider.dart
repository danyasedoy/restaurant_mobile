import 'package:app/models/entities/order_entity.dart';

class ApiProvider {
  Future<dynamic> login(String login, String password) async{
    // ждем токен
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> register(String login, String password, String firstName, String lastName, String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> getRoleByToken(String token) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> getAvailableTablesByDate(DateTime date) async {
    // ждем список свободных столиков
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> getBookingByUser() async {
    // ждем букинг или его отсутствие
    // букинг: номер столика и дата
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> bookTable(DateTime date, int tableNum) async {
    // ждем ответ - забучили или нет
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> cancelBooking() async {
    // ждем ответ - закенселили или нет
    // если что то у одного юзера максимум один букинг
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> getProductsList() async {
    // ждем список продуктов
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> proceedOrder(OrderEntity order) async {
    // отправляем заказ пользователя
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<dynamic> getUserOrders() async {
    // ждем список заказов пользователя (и старых и активных)
    await Future.delayed(const Duration(seconds: 2));
  }

}