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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text('Рабочие даты:', style: TextStyle(fontSize: 20)),
                const Divider(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: ListView.builder(
                    itemCount: shift.workingDates.length,
                    itemBuilder: (context, index) =>
                      Center(
                        child: Card(
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                            side: const BorderSide(
                              color: Colors.deepOrange,
                              width: 2.0,
                            ),
                          ),
                          elevation: 6,
                          shadowColor: Colors.deepOrange,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                            child: Text(DateFormat("dd.MM.yyyy").format(shift.workingDates[index])),
                          ),
                        ),
                      )
                  ),
                ),
                const Text('Номера столов', style: TextStyle(fontSize: 20)),
                const Divider(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: shift.tableNumbers.map((num) =>
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Chip(label: Text(num.toString())),
                      )
                    ).toList(),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Нет данных о смене'));
        }
      },
    );
  }
}
