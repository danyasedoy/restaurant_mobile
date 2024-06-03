import 'package:app/models/services/abstract_service.dart';

abstract class AbstractViewModel {
  final AbstractService service;

  AbstractViewModel(this.service);

  String getRole() {
    // TODO
    return "";
  }
}