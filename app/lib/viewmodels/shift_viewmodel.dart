import 'package:app/models/services/shift_service.dart';
import 'package:app/viewmodels/abstract_viewmodel.dart';

import '../models/entities/shift_entity.dart';

class ShiftViewModel extends AbstractViewModel {
  @override
  final ShiftService service = ShiftService();

  Future<ShiftEntity> fetchShiftData() async {
    return await service.getShift();
  }
}