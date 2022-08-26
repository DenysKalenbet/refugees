import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:refugees/refugees_data.dart';
import 'package:refugees/screens/all_countries.dart';
import 'package:refugees/screens/update_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../assets/ref_data.dart';
import '../widgets/ReugeesTile.dart';

class Dashboard extends StatelessWidget {
  static const routeName = "/dashboard-screen";

  @override
  Widget build(BuildContext context) {
    final refugeesData = Provider.of<RefugeesData>(context);
    final countTopCountries = refugeesData.countryCount;

    final List<RefData> data = refugeesData.dataForChart;
    final digitsFormat = NumberFormat(",###");
    final dateFormat = DateFormat('dd-MM-yyyy');

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      ' ${digitsFormat.format(refugeesData.totalAmount.individuals).toString()}',
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                      'updated ${dateFormat.format(refugeesData.totalAmount.date).toString()}')
                ],
              ),
            ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Refugees increment'),
              // Enable legend
              legend: Legend(isVisible: false),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<RefData, String>>[
                LineSeries<RefData, String>(
                  dataSource: data,
                  xValueMapper: (RefData ref, _) => ref.year,
                  yValueMapper: (RefData ref, _) => ref.refCount,
                  name: 'Refugees',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Top 5 countries',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            RefugeesTile(
              refugeesData: refugeesData,
              countTopCountries: countTopCountries,
              dateFormat: dateFormat,
              digitsFormat: digitsFormat,
              listCount: 5,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AllCountries.routeName);
              },
              child: const Text('All countries'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(UpdateData.routeName);
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
