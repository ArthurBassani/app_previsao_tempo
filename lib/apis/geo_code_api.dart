import 'package:app_previsao_tempo/models/city_spec.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GeoCodeApi {
  Future<List<CitySpec>> fetchCities({required String city}) async {
    List<CitySpec> cities = [];
    try {
      final response = await http.get(Uri.parse(
          'https://geocoding-api.open-meteo.com/v1/search?name=$city&language=pt&format=json'));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        var results = decodedJson['results'] as List;
        cities = results.map((json) => CitySpec.fromJson(json)).toList();
        return cities;
      } else {
        throw Exception('Failed to load cities');
      }
    } on Exception catch (e) {
      print(e);
    }
    return cities;
  }
}
