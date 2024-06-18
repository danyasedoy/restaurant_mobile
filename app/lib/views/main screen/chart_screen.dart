import 'package:app/viewmodels/chart_viewmodel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChartViewModel(),
      child: Consumer<ChartViewModel> (
        builder: (context, viewModel, child) {
          return FutureBuilder(future: viewModel.fetchChartData(), builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasError) {
              return Center(child: Text('Ошибка: ${snapshot.error}'));
            }
            else if (!snapshot.hasData) {
              return const Center(child: Text('Данных пока нет'));
            }
            else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Количество заказов: "),
                    ),
                    SizedBox(
                      height: 300,
                      child: _BarChart(snapshot.data!.dayAndOrdersCount)
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Сумма чеков: "),
                    ),
                    SizedBox(
                      height: 300,
                      child: _BarChart(snapshot.data!.dayAndOrdersSum)
                    ),
                    SizedBox(height: 60,)
                  ],
                ),
              );
            }
          });
        },
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart(this.data);
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: _getMaxY(), // Calculate max Y value dynamically
        barTouchData: BarTouchData(
          enabled: true, // Disable touch interactions for now
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: _bottomTitles,
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60,
              interval: _getYInterval(), // Calculate Y interval dynamically
              getTitlesWidget: _leftTitles,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: _barGroups,
        gridData: FlGridData(show: false),
      ),
    );
  }

  // Calculate the maximum Y value for the chart
  double _getMaxY() {
    double max = 0;
    data.values.forEach((value) {
      if (value.toDouble() > max) {
        max = value.toDouble();
      }
    });
    return max;
  }

  // Calculate a suitable interval for Y-axis labels
  double _getYInterval() {
    final maxY = _getMaxY();
    if (maxY <= 10) return 2;
    if (maxY <= 50) return 5;
    if (maxY <= 100) return 10;
    return maxY / 4; // Adjust as needed for larger values
  }

  // Generate BarChartGroupData from your data map
  List<BarChartGroupData> get _barGroups {
    int index = 0;
    return data.entries.map((entry) {
      return BarChartGroupData(
        x: index++,
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            width: 16, // Adjust bar width as needed
            gradient: LinearGradient( // Add gradient here
              colors: [
                Colors.red, // Start color
                Colors.green, // End color
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }

  // Widget for Y-axis titles (values)
  Widget _leftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        value.toInt().toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  // Widget for X-axis titles (dates/keys)
  Widget _bottomTitles(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index >= data.keys.length) return const SizedBox.shrink(); // Handle potential index out of bounds

    final date = data.keys.elementAt(index);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        date, // Display the date/key
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

