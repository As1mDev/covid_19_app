import 'package:covid_19_app/apis/world_states_api.dart';
import 'package:covid_19_app/models/world_states_model.dart';
import 'package:covid_19_app/screens/countries_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
    const Color(0xff00ff00),
  ];

  WorldStatesApi worldStatesApi = WorldStatesApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 39, 39),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .06,
            ),
            FutureBuilder(
              future: worldStatesApi.getAllWorldStatesData(),
              builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: controller,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total":
                              double.parse(snapshot.data!.cases.toString()),
                          "Recovered":
                              double.parse(snapshot.data!.recovered.toString()),
                          "Deaths":
                              double.parse(snapshot.data!.deaths.toString()),
                          "Active":
                              double.parse(snapshot.data!.active.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        animationDuration: const Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorList,
                        chartRadius: MediaQuery.of(context).size.width / 2.8,
                        legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * .035),
                        child: Card(
                          color: const Color.fromARGB(255, 52, 49, 49),
                          child: Column(
                            children: [
                              ReusedableRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases.toString()),
                              ReusedableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered.toString()),
                              ReusedableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths.toString()),
                              ReusedableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString()),
                              ReusedableRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical.toString()),
                              ReusedableRow(
                                  title: 'Today Deaths',
                                  value: snapshot.data!.todayDeaths.toString()),
                              ReusedableRow(
                                  title: 'Today Recovered',
                                  value:
                                      snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const CountriesScreen();
                          }));
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff1aa260)),
                          child: const Center(
                              child: Text(
                            'Track Countries',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                fontSize: 16),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}

// ignore: must_be_immutable
class ReusedableRow extends StatelessWidget {
  String title, value;
  ReusedableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Color.fromARGB(255, 87, 87, 87),
          )
        ],
      ),
    );
  }
}
