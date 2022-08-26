import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../refugees_data.dart';

class Header extends StatelessWidget {
  final country;

  const Header(this.country);

  @override
  Widget build(BuildContext context) {
    final refugeesData = Provider.of<RefugeesData>(context);
    final digitsFormat = NumberFormat(",###");
    final dateFormat = DateFormat('dd-MM-yyyy');

    return Column(children: [
      Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Total refugees',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                ' ${digitsFormat.format(refugeesData.latestCountryData(country).individuals).toString()}',
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
                'updated ${dateFormat.format(refugeesData.latestCountryData(country).date).toString()}')
          ],
        ),
      )
    ]);
  }
}
