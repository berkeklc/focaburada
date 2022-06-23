import 'package:focaburada/data/Categories.dart';

class CategoriesReturn{
  int success;
  List<Categories> categoriesList;

  CategoriesReturn(this.success, this.categoriesList);
  factory CategoriesReturn.fromJson(Map<String,dynamic> json){
    var jsonArray = json ["post1_wrap"] as List;
    List<Categories> categoriesList = jsonArray.map((jsonArrayNesnesi) => Categories.fromJson(jsonArrayNesnesi)).toList();

    return CategoriesReturn(json["success"] as int, categoriesList);
  }
}