import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_oracle_digital/features/search/data/models/cities_model.dart';
import 'package:test_oracle_digital/internal/helpers/api_requester/api_requester.dart';

final cityApiServiceProvider = StateProvider((ref) => CityApiService());

final citiesProvider = FutureProvider<List<CitiesModel>>((ref) async {
  final cityApiService = ref.read(cityApiServiceProvider);

  return await cityApiService.fetchCities();
});

// Провайдер для хранения поискового запроса
final searchQueryProvider = StateProvider<String>((ref) => '');

// Провайдер для получения городов с учетом поискового запроса
final citiesProviderSecond = FutureProvider<List<CitiesModel>>((ref) async {
  final cityApiService = ref.read(cityApiServiceProvider);
  final searchQuery = ref.watch(searchQueryProvider);

  return await cityApiService.fetchCities(searchQuery: searchQuery);
});
