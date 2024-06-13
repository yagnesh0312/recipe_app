import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/model/data.dart';

class RecipeController extends GetxController {
  var searchedRecipes = <Map<String, String?>>[].obs;
  var recipes = <Map<String, String?>>[].obs;
  var category = [].obs;
  var fevIdList = [];
  var catListSelected = [].obs;

  final GetStorage _box = GetStorage();
  onCatListClick(String id) {
    if (catListSelected.contains(id)) {
      catListSelected.remove(id);
    } else {
      catListSelected.add(id);
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getItems(10);
    getCatList();
    getFevList();
  }

  Future<List<Map<String, String?>>> getMealsByCategory(CategoryModel c) async {
    var response = await http.get(Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=${c.strCategory}"));
    Recipes rs = RecipesFromJson(response.body);
    return rs.meals;
    // https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
  }

  getFevList() {
    fevIdList = _box.read("fevId")??[];
    update();
  }

  fevContains(String id) {
    return fevIdList.contains(id);
  }

  onFevClick(String id) {
    if (!fevContains(id)) {
      addFevList(id);
    } else {
      removeFevList(id);
    }

    update();
  }

  addFevList(String id) {
    fevIdList.add(id);

    _box.write("fevId", fevIdList);
    _box.save();
    update();
  }

  removeFevList(String id) {
    fevIdList.remove(id);
    _box.write("fevId", fevIdList);
    _box.save();
    update();
  }

  getItems(int length) async {
    recipes.value = [];
    // var res = <Map<String, String?>>[];
    for (var i = 0; i < length; i++) {
      var response = await http
          .get(Uri.parse("http://www.themealdb.com/api/json/v1/1/random.php"));
      recipes.add(RecipesFromJson(response.body).meals[0]);
      update();
    }
    // recipes.value = res;
    // print(res);
  }

  searchData(String s) async {
    if (s.isEmpty) {
      searchedRecipes.value = recipes.value;
    } else {
      var response = await http.get(
          Uri.parse("http://www.themealdb.com/api/json/v1/1/search.php?s=$s"));
      print(response.body);
      Recipes rs = RecipesFromJson(response.body);
      searchedRecipes.value = rs.meals;
    }
    update();
  }

  listAllMealByFirstLatter(String s) {
    // www.themealdb.com/api/json/v1/1/search.php?f=a
  }

  Future<Map<String, String?>> getMealById(String id) async {
    var response = await http.get(
        Uri.parse("http://www.themealdb.com/api/json/v1/1/lookup.php?i=$id"));
    Recipes rs = RecipesFromJson(response.body);
    print(response.body);
    return rs.meals[0] as Map<String, String?>;
    // www.themealdb.com/api/json/v1/1/lookup.php?i=52772
  }

  getOneRandomMeal() {
    // www.themealdb.com/api/json/v1/1/random.php
  }

  getCatList() async {
    var response = await http.get(
        Uri.parse("http://www.themealdb.com/api/json/v1/1/categories.php"));
    category.value =
        catListFromJson(response.body).categories as List<CategoryModel>;
    print(response.body);
    // www.themealdb.com/api/json/v1/1/categories.php
    update();
  }

  getMealByIngredient() {
    // www.themealdb.com/api/json/v1/1/filter.php?i=chicken_breast
  }
}
