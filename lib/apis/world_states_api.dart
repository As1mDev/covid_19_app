import 'dart:convert';

import 'package:covid_19_app/models/world_states_model.dart';
import 'package:covid_19_app/utilities/api_url.dart';
import 'package:http/http.dart' as http;

class WorldStatesApi {
  Future<WorldStatesModel> getAllWorldStatesData() async {
    var response = await http.get(Uri.parse(ApiUrl.worldStatesApi));
    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return WorldStatesModel.fromJson(responseData);
    } else {
      throw Exception('Error');
    }
  }
}

class CountriesApi {
  Future<List<dynamic>> getAllCountries() async {
    var response = await http.get(Uri.parse(ApiUrl.countriesList));
    var responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return responseData;
    } else {
      throw Exception('Error');
    }
  }
}
