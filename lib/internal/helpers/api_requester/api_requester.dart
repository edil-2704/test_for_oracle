import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_oracle_digital/features/search/data/models/cities_model.dart';

class CityApiService {
  final Dio _dio = Dio();

  Future<List<CitiesModel>> fetchCities({String searchQuery = ''}) async {
    try {
      final response = await _dio.get(
        'https://odigital.pro/locations/cities/',
        queryParameters: {'search': searchQuery},
      );

      // Сохраняем данные в локальное хранилище
      final List<CitiesModel> cities =
          citiesModelFromJson(jsonEncode(response.data));
      await _cacheCities(cities);

      return cities;
    } catch (e) {
      // Если произошла ошибка (например, нет интернет-соединения), то загружаем данные из кеша
      return await _loadCitiesFromCache();
    }
  }

  Future<void> _cacheCities(List<CitiesModel> cities) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = citiesModelToJson(cities);
    await prefs.setString('cities_cache', jsonString);
  }

  Future<List<CitiesModel>> _loadCitiesFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('cities_cache');

    if (jsonString != null) {
      return citiesModelFromJson(jsonString);
    } else {
      return []; // Возвращаем пустой список, если кеша нет
    }
  }
}
