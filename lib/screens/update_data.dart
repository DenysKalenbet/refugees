import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../assets/refugees_country.dart';

class UpdateData extends StatelessWidget {
  // const UpdateData({Key? key}) : super(key: key);

  static const routeName = '/update-data';

  final db = FirebaseFirestore.instance;

  final RefugeesAllCountries = <String, dynamic>{
    "refugees_all_countries": RefugeesByCountry.refugeesByCountryJSON,
    "timestamp": DateTime.now().toString()
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(children: [
        TextButton(
          onPressed: () {
            db.collection("refugees").add(RefugeesAllCountries).then(
                (DocumentReference doc) =>
                    print('DocumentSnapshot added with ID: ${doc.id}'));
          },
          child: Text('Save'),
        ),
        TextButton(
          onPressed: () async {
            await db.collection("refugees").get().then((event) {
              for (var doc in event.docs) {
                print("I have read ${doc.id} => ${doc.data()}");
              }
            });
          },
          child: Text('Get'),
        ),
      ]),
    );
  }
}
