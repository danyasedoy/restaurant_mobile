import 'dart:convert';

import 'package:app/models/services/abstract_service.dart';

import '../entities/chart_data.dart';

class ChartService extends AbstractService {
  Future<ChartData> getChartData() async{
    final token = await storageProvider.loadToken();
    final response = await apiProvider.getReportData(token!);
    final ChartData charts = ChartData();
    if (response.statusCode == 200) {
      for (final dayData in jsonDecode(response.body)) {
        charts.dayAndOrdersCount[dayData['date']] = dayData['orders'];
        charts.dayAndOrdersSum[dayData['date']] = dayData['total'].toDouble();
      }
    }
    return charts;
  }
}