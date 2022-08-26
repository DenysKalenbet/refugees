import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../refugees_data.dart';
import '../widgets/ReugeesTile.dart';

class AllCountries extends StatelessWidget {
  const AllCountries({Key? key}) : super(key: key);

  static const routeName = "/all-countries";

  @override
  Widget build(BuildContext context) {
    final refugeesData = Provider.of<RefugeesData>(context);
    final countTopCountries = refugeesData.countryCount;

    final digitsFormat = NumberFormat(",###");
    final dateFormat = DateFormat('dd-MM-yyyy');

    return Scaffold(
        appBar: AppBar(title: Text('All countries details')),
        body: Column(children: [
          RefugeesTile(
            refugeesData: refugeesData,
            countTopCountries: countTopCountries,
            dateFormat: dateFormat,
            digitsFormat: digitsFormat,
            listCount: -1,
          ),
        ]));
  }
}
