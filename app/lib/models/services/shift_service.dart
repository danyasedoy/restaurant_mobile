import 'package:app/models/services/abstract_service.dart';
import '../entities/shift_entity.dart';

class ShiftService extends AbstractService {
  Future<ShiftEntity> getShift() async {
    await apiProvider.getShiftData();
    return ShiftEntity([DateTime.now()], [1, 5, 6]);
  }
}