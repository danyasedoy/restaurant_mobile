import 'package:app/models/services/abstract_service.dart';
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

}

class EnterViewModel extends AbstractViewModel with ChangeNotifier {
  final state = EnterScreenState();
  @override
  final service = EnterService() as AbstractService;

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
    if (newName.isEmpty || newName.length < 8) {
      state.isFirstNameValid = false;
    }
    else{
      state.isFirstNameValid = true;
      state.firstName = newName;
    }
    notifyListeners();
  }

  validateLastName(String newName) {
    if (newName.isEmpty || newName.length < 8) {
      state.isLastNameValid = false;
    }
    else{
      state.isLastNameValid = true;
      state.lastName = newName;
    }
    notifyListeners();
  }

  validatePhoneNumber(String newNumber) {
    if (newNumber.isEmpty || newNumber.length < 8) {
      state.isPhoneNumberValid = false;
    }
    else{
      state.isPhoneNumberValid = true;
      state.phoneNumber = newNumber;
    }
    notifyListeners();
  }

  bool isValidated() {
    return state.isLoginValid && state.isPasswordValid && state.isFirstNameValid && state.isLastNameValid && state.isPhoneNumberValid;
  }

}

