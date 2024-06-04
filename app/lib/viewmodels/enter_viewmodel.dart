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

