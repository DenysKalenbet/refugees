import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../assets/ref_data.dart';
import '../refugees_data.dart';
import '../widgets/header.dart';

class CountryDetails extends StatelessWidget {
  const CountryDetails({Key? key, required country}) : super(key: key);

  static const routeName = "/country-details";

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as String;
    final refugeesData = Provider.of<RefugeesData>(context);
    final List<RefData> data2 = refugeesData.refugeesByCountryForChart(arg);

    final countryDetails = RefugeesData().latestCountryData(arg);

    return Scaffold(
      appBar: AppBar(title: Text('Country $arg details')),
      body: Column(
        children: [
          Header(arg),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Refugees in $arg'),
              // Enable legend
              legend: Legend(isVisible: false),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<RefData, String>>[
                LineSeries<RefData, String>(
                  dataSource: data2,
                  xValueMapper: (RefData ref, _) => ref.year,
                  yValueMapper: (RefData ref, _) => ref.refCount,
                  name: 'Refugees',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: false),
                ),
              ],
            ),
          ),
          Text('Data source ${refugeesData.latestCountryData(arg).source}'),
        ],
      ),
    );
  }
}
