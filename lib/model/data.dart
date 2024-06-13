// To parse this JSON data, do
//
//     final Recipes = RecipesFromJson(jsonString);

import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Recipes RecipesFromJson(String str) => Recipes.fromJson(json.decode(str));
Future<Recipes> RecipesFromJsonFile(String str) async {
  final String input = await rootBundle.loadString(str);
  return RecipesFromJson(input);
}

String RecipesToJson(Recipes data) => json.encode(data.toJson());

class Recipes {
  List<Map<String, String?>> meals;

  Recipes({
    required this.meals,
  });

  factory Recipes.fromJson(Map<String, dynamic> json) => Recipes(
        meals: List<Map<String, String?>>.from(json["meals"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
}
// category data

CatList catListFromJson(String str) => CatList.fromJson(json.decode(str));

String catListToJson(CatList data) => json.encode(data.toJson());

class CatList {
    List<CategoryModel> categories;

    CatList({
        required this.categories,
    });

    factory CatList.fromJson(Map<String, dynamic> json) => CatList(
        categories: List<CategoryModel>.from(json["categories"].map((x) => CategoryModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

class CategoryModel {
    String idCategory;
    String strCategory;
    String strCategoryThumb;
    String strCategoryDescription;

    CategoryModel({
        required this.idCategory,
        required this.strCategory,
        required this.strCategoryThumb,
        required this.strCategoryDescription,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        idCategory: json["idCategory"],
        strCategory: json["strCategory"],
        strCategoryThumb: json["strCategoryThumb"],
        strCategoryDescription: json["strCategoryDescription"],
    );

    Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription": strCategoryDescription,
    };
}


Filter filterFromJson(String str) => Filter.fromJson(json.decode(str));

String filterToJson(Filter data) => json.encode(data.toJson());

class Filter {
    List<Meal> meals;

    Filter({
        required this.meals,
    });

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
    };
}

class Meal {
    String strMeal;
    String strMealThumb;
    String idMeal;

    Meal({
        required this.strMeal,
        required this.strMealThumb,
        required this.idMeal,
    });

    factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
    );

    Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
    };
}
