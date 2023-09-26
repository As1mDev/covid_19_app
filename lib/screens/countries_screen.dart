import 'package:covid_19_app/apis/world_states_api.dart';
import 'package:covid_19_app/screens/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  TextEditingController searchController = TextEditingController();
  CountriesApi countriesApi = CountriesApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 39, 39),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 41, 39, 39),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: countriesApi.getAllCountries(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: 40,
                                width: 50,
                                color: Colors.white,
                              ),
                              title: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                              trailing: Container(
                                height: 10,
                                width: 50,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];

                      if (searchController.text.isEmpty) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return CountryDetailScreen(
                                      country: snapshot.data![index]['country'],
                                      image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                      cases: snapshot.data![index]['cases'],
                                      deaths: snapshot.data![index]['deaths'],
                                      recovered: snapshot.data![index]
                                          ['recovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                      todayRecovered: snapshot.data![index]
                                          ['todayRecovered'],
                                      tests: snapshot.data![index]['tests']);
                                }));
                              },
                              child: ListTile(
                                leading: Image(
                                    width: 50,
                                    height: 40,
                                    fit: BoxFit.fill,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    'Effected: ${snapshot.data![index]['cases'].toString()}'),
                                trailing:
                                    Text(snapshot.data![index]['continent']),
                              ),
                            ),
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return CountryDetailScreen(
                                      country: snapshot.data![index]['country'],
                                      image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                      cases: snapshot.data![index]['cases'],
                                      deaths: snapshot.data![index]['deaths'],
                                      recovered: snapshot.data![index]
                                          ['recovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                      todayRecovered: snapshot.data![index]
                                          ['todayRecovered'],
                                      tests: snapshot.data![index]['tests']);
                                }));
                              },
                              child: ListTile(
                                leading: Image(
                                    width: 50,
                                    height: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    'Effected: ${snapshot.data![index]['cases'].toString()}'),
                                trailing:
                                    Text(snapshot.data![index]['continent']),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
