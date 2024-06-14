import 'dart:convert';

import 'package:app/models/services/abstract_service.dart';
import 'package:intl/intl.dart';
import '../entities/shift_entity.dart';

class ShiftService extends AbstractService {
  Future<ShiftEntity> getShift() async {
    final token = await storageProvider.loadToken();
    final response = await apiProvider.getShiftData(token!);
    final shiftJson = jsonDecode(response.body);
    final ShiftEntity shift = ShiftEntity([], []);
    for (final dateJson in shiftJson["shifts"]) {
      shift.workingDates.add(DateFormat("dd.MM.yyyy").parse(dateJson));
    }
    for (final tableNum in shiftJson["tables"]) {
      shift.tableNumbers.add(tableNum);
    }
    return shift;
  }
}