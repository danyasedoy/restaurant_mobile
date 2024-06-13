import 'dart:convert';

import 'package:app/models/services/abstract_service.dart';

class EnterService extends AbstractService {
  Future<bool> login(String login, String password) async {
    var response = await apiProvider.login(login, password);
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body);
      await storageProvider.saveToken(token);
      final userDataResponse = await apiProvider.getRoleByToken(token);

      if (userDataResponse.statusCode == 200) {
        await storageProvider.saveUserRoleId(jsonDecode(userDataResponse.body)["role_id"]);
      }
      else  {
        // TODO ошибки выводи да
        return false;
      }

      return true;
    }
    else {
      // TODO ошибки выводи да
      return false;
    }
  }

  Future<bool> register(String login, String password, String firstName, String lastName, String phoneNumber) async{
    final response = await apiProvider.register(login, password, firstName, lastName, phoneNumber);
    if (response.statusCode == 200) {
      return true;
    }
    else {
      // TODO ошибки выводи да
      return false;
    }
  }
}