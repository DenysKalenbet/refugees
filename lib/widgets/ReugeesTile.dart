import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../country_code.dart';
import '../refugees_data.dart';
import '../screens/country_details.dart';

class RefugeesTile extends StatelessWidget {
  const RefugeesTile({
    Key? key,
    required this.refugeesData,
    required this.countTopCountries,
    required this.dateFormat,
    required this.digitsFormat,
    required this.listCount,
  }) : super(key: key);

  final RefugeesData refugeesData;
  final int countTopCountries;
  final DateFormat dateFormat;
  final NumberFormat digitsFormat;
  final int listCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: listCount == -1
          ? refugeesData.topXCountriesStat(countTopCountries).length
          : listCount,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, CountryDetails.routeName,
                arguments:
                    '${refugeesData.topXCountriesStat(countTopCountries)[index].country}');
          },
          leading: (CountryCode.countryCode[refugeesData
                      .topXCountriesStat(countTopCountries)[index]
                      .country] !=
                  null)
              ? Image.asset(
                  'icons/flags/png/2.5x/${CountryCode.countryCode[refugeesData.topXCountriesStat(countTopCountries)[index].country]}.png',
                  package: 'country_icons',
                  height: 20.0)
              : Text('No Flag'),
          title: Text(
              '${refugeesData.topXCountriesStat(countTopCountries)[index].country}'),
          subtitle: Text(
              'last update ${dateFormat.format(refugeesData.topXCountriesStat(countTopCountries)[index].date)}'),
          trailing: Text(
              '${digitsFormat.format(refugeesData.topXCountriesStat(countTopCountries)[index].individuals)}'),
        ),
      ),
    );
  }
}
