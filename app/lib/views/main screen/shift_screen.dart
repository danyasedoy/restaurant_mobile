import 'package:app/viewmodels/shift_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/entities/shift_entity.dart';

class ShiftScreen extends StatelessWidget {
  const ShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ShiftViewModel();
    return FutureBuilder<ShiftEntity>(
      future: viewModel.fetchShiftData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final shift = snapshot.data!;
          final dateFormat = DateFormat('dd.MM.yyyy');
          return Column(
            children: [
              Text('Рабочие даты: ${shift.workingDates.map((date) => dateFormat.format(date)).join(', ')}'),
              Text('Номера столов: ${shift.tableNumbers.join(', ')}')
            ],
          );
        } else {
          return const Center(child: Text('Нет данных о смене'));
        }
      },
    );
  }
}
