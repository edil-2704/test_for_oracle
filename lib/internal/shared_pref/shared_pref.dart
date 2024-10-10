import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_oracle_digital/features/search/data/models/cities_model.dart';

class CityCacheService {
  Future<void> cacheCities(List<CitiesModel> cities) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonData = citiesModelToJson(cities);
    await prefs.setString('cached_cities', jsonData);
  }

  Future<List<CitiesModel>?> getCachedCities() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('cached_cities');
    if (jsonData != null) {
      return citiesModelFromJson(jsonData);
    }
    return null;
  }
}
