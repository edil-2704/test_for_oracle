// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cities_model.freezed.dart';
part 'cities_model.g.dart';

// Конвертация из JSON-строки в List<CitiesModel>
List<CitiesModel> citiesModelFromJson(String str) =>
    List<CitiesModel>.from(json.decode(str).map((x) => CitiesModel.fromJson(x)));

// Конвертация из List<CitiesModel> в JSON-строку
String citiesModelToJson(List<CitiesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class CitiesModel with _$CitiesModel {
  const factory CitiesModel({
    required String name,
    required String slug,
  }) = _CitiesModel;

  // Генерация метода для преобразования из JSON
  factory CitiesModel.fromJson(Map<String, dynamic> json) => _$CitiesModelFromJson(json);
}