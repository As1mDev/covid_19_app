import 'package:covid_19_app/screens/worldstates_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CountryDetailScreen extends StatefulWidget {
  String country;
  String image;
  int cases, deaths, recovered, active, critical, todayRecovered, tests;
  // ignore: use_key_in_widget_constructors
  CountryDetailScreen({
    required this.country,
    required this.image,
    required this.cases,
    required this.deaths,
    required this.recovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.tests,
  });

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 39, 39),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 52, 49, 49),
        title: Text(
          widget.country,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .067),
                    child: Card(
                      color: const Color.fromARGB(255, 52, 49, 49),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .06,
                          ),
                          ReusedableRow(
                              title: 'Cases', value: widget.cases.toString()),
                          ReusedableRow(
                              title: 'Recovered',
                              value: widget.recovered.toString()),
                          ReusedableRow(
                              title: 'Deaths', value: widget.deaths.toString()),
                          ReusedableRow(
                              title: 'Critical',
                              value: widget.critical.toString()),
                          ReusedableRow(
                              title: 'Today Recovered',
                              value: widget.todayRecovered.toString()),
                          ReusedableRow(
                              title: 'Active', value: widget.active.toString()),
                          ReusedableRow(
                              title: 'Tests', value: widget.tests.toString()),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
