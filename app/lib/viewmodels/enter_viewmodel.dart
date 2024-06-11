import 'package:app/models/services/enter_service.dart';
import 'package:app/viewmodels/abstract_viewmodel.dart';
import 'package:flutter/material.dart';

class EnterScreenState {
  String? login;
  bool isLoginValid = false;

  String? password;
  bool isPasswordValid = false;

  String? firstName;
  bool isFirstNameValid = false;

  String? lastName;
  bool isLastNameValid = false;

  String? phoneNumber;
  bool isPhoneNumberValid = false;

  var registrationStatus = RegistrationStatus.initial;
  var loginStatus = LoginStatus.initial;

  int? roleId;

  void reset() {
    login = null;
    isLoginValid = false;
    password = null;
    isPasswordValid = false;
    firstName = null;
    isFirstNameValid = false;
    lastName = null;
    isLastNameValid = false;
    phoneNumber = null;
    isPhoneNumberValid = false;
    registrationStatus = RegistrationStatus.initial;
    loginStatus = LoginStatus.initial;
    roleId = null;
  }

}

class EnterViewModel extends AbstractViewModel with ChangeNotifier {
  final state = EnterScreenState();
  @override
  final EnterService service = EnterService();

  Future<void> login() async{
    state.loginStatus = LoginStatus.loading;
    notifyListeners();

    var response = await service.login(state.login!, state.password!);

    if (response) {
      state.roleId = await service.getRoleId();
      state.loginStatus = LoginStatus.success;
    }
    else {
      state.loginStatus = LoginStatus.error;
    }

    if (state.loginStatus == LoginStatus.error) {
      state.reset();
      state.loginStatus = LoginStatus.error;
    }
    notifyListeners();

  }

  Future<void> register() async{
    state.registrationStatus = RegistrationStatus.loading;
    notifyListeners();

    final response = await service.register(state.login!, state.password!, state.firstName!, state.lastName!, state.phoneNumber!);

    if (response){
      state.registrationStatus = RegistrationStatus.success;
    }
    else {
      state.registrationStatus = RegistrationStatus.error;
    }

    if (state.registrationStatus == RegistrationStatus.error) {
      state.reset();
      state.registrationStatus = RegistrationStatus.error;
    }
    notifyListeners();
  }

  validateLogin(String newLogin) {
    if (newLogin.isEmpty || newLogin.length < 8) {
      state.isLoginValid = false;
    }
    else {
      state.isLoginValid = true;
      state.login = newLogin;
    }
    notifyListeners();
  }

  validatePassword(String newPassword) {
    if (newPassword.isEmpty || newPassword.length < 8) {
      state.isPasswordValid = false;
    }
    else{
      state.isPasswordValid = true;
      state.password = newPassword;
    }
    notifyListeners();
  }

  validateFirstName(String newName) {
    if (newName.isEmpty || newName.length < 2) {
      state.isFirstNameValid = false;
    }
    else{
      state.isFirstNameValid = true;
      state.firstName = newName;
    }
    notifyListeners();
  }

  validateLastName(String newName) {
    if (newName.isEmpty || newName.length < 2) {
      state.isLastNameValid = false;
    }
    else{
      state.isLastNameValid = true;
      state.lastName = newName;
    }
    notifyListeners();
  }

  validatePhoneNumber(String newNumber) {
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    if (newNumber.isEmpty || !phoneRegex.hasMatch(newNumber)) {
      state.isPhoneNumberValid = false;
    } else {
      state.isPhoneNumberValid = true;
      state.phoneNumber = newNumber;
    }
    notifyListeners();
  }

  bool isValidated({bool isForAuth = false}) {
    if (isForAuth) {
      return state.isLoginValid && state.isPasswordValid;
    }
    return state.isLoginValid && state.isPasswordValid && state.isFirstNameValid && state.isLastNameValid && state.isPhoneNumberValid;
  }


}

enum RegistrationStatus {
  initial,
  loading,
  success,
  error
}

enum LoginStatus {
  initial,
  loading,
  success,
  error
}


