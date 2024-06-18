import 'package:app/models/entities/chart_data.dart';
import 'package:app/models/services/chart_service.dart';
import 'package:app/viewmodels/abstract_viewmodel.dart';
import 'package:flutter/cupertino.dart';

class ChartViewModel extends AbstractViewModel with ChangeNotifier {
  @override
  final ChartService service = ChartService();

  Future<ChartData> fetchChartData() async {
    return await service.getChartData();
  }
}