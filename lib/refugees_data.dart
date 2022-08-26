import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:refugees/assets/refugees_total.dart';

import 'assets/ref_data.dart';
import 'assets/refugees_country.dart';

class RefugeesData with ChangeNotifier {
  final _refugeesByCountry =
      refugeesByCountryFromJson(RefugeesByCountry.refugeesByCountryJSON);
  final _refugeesTotal = refugeesTotalFromJson(RefugeesTotal.refugeesTotalJSON);

  List<RefData> get dataForChart {
    List<RefData> data = [];
    var i = 1;
    for (var individualsDay in _refugeesTotal) {
      data.add(RefData(
          '${individualsDay.date.day}.${individualsDay.date.month.toString()}',
          individualsDay.individuals));
      i++;
    }
    return data;
  }

  latestCountryData(country) {
    return _refugeesByCountry
        .where((element) => element.country == country)
        .reduce((value, element) =>
            value.date.isAfter(element.date) ? value : element);
  }

  List<RefData> refugeesByCountryForChart(String country) {
    List<RefData> data = [];
    var i = 1;
    var refugeesByCountry = _refugeesByCountry
        .where((element) => element.country == country)
        .toList();

    refugeesByCountry.sort((a, b) => a.date.compareTo(b.date));

    for (var individualsDay in refugeesByCountry) {
      data.add(RefData(
          '${individualsDay.date.day}.${individualsDay.date.month.toString()}',
          individualsDay.individuals));
      i++;
    }
    // if (kDebugMode) {
    //   for (var element in data) {
    //     print(element.refCount);
    //   }
    // }
    return data;
  }

  List refugeesByCountry(String country) {
    return _refugeesByCountry
        .where((element) => element.country == country)
        .toList();
  }

  get totalAmount {
    return _refugeesTotal.reduce(
        (value, element) => value.date.isAfter(element.date) ? value : element);
  }

  get _lastUpdatedDateByCountry {
    return _refugeesByCountry
        .reduce((value, element) =>
            value.date.isAfter(element.date) ? value : element)
        .date;
  }

  get lastRefugeesByCountry {
    return _refugeesByCountry
        .where((element) => element.date == _lastUpdatedDateByCountry)
        .toList();
  }

  List get _countryList {
    List<String> countryList = [];
    for (var refugee in _refugeesByCountry) {
      countryList.add(refugee.country);
    }
    return countryList.toSet().toList();
  }

  int get countryCount {
    List<String> countryList = [];
    for (var refugee in _refugeesByCountry) {
      countryList.add(refugee.country);
    }
    return countryList.toSet().toList().length;
  }

  List get latestStatPerCountry {
    var countryList = _countryList;
    List latestStat = [];
    for (var country in countryList) {
      latestStat.add(_refugeesByCountry
          .where((element) => element.country == country)
          .toList()
          .reduce((value, element) =>
              value.date.isAfter(element.date) ? value : element));
    }
    return latestStat;
  }

  List topXCountriesStat(int x) {
    //latestStatPerCountry.sort((a, b) => a.individuals.compareTo(b.individuals));
    List topX = latestStatPerCountry;
    topX.sort((a, b) => b.individuals.compareTo(a.individuals));
    topX = topX.sublist(0, x);
    return topX;
  }
}
