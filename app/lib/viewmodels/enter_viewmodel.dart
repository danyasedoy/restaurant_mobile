import 'package:app/viewmodels/abstract_viewmodel.dart';
import 'package:flutter/material.dart';

class EnterScreenState {
  String? message;
}

class EnterViewModel extends AbstractViewModel with ChangeNotifier {
  final _state = EnterScreenState();
  EnterViewModel(super.service);

}

