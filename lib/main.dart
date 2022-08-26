import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refugees/refugees_data.dart';
import 'package:refugees/screens/all_countries.dart';
import 'package:refugees/screens/country_details.dart';
import 'package:refugees/screens/dashboard.dart';
import 'package:refugees/screens/update_data.dart';

import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RefugeesData()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Dashboard(),
        routes: {
          CountryDetails.routeName: (context) => const CountryDetails(
                country: '',
              ),
          AllCountries.routeName: (context) => const AllCountries(),
          UpdateData.routeName: (context) => UpdateData()
        },
      ),
    );
  }
}
