import 'package:app/models/services/abstract_service.dart';

class EnterService extends AbstractService {
  Future<bool> login(String login, String password) async {
    var response = await apiProvider.login(login, password);
    await storageProvider.saveUserRoleId(1);
    return true;
  }

  Future<bool> register(String login, String password, String firstName, String lastName, String phoneNumber) async{
    var response = apiProvider.register(login, password, firstName, lastName, phoneNumber);
    return true;
  }
}