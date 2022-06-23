import 'Cities.dart';

class CitiesReturn{
  int success;
  List<Cities> citiesList;

  CitiesReturn(this.success, this.citiesList);
  factory CitiesReturn.fromJson(Map<String,dynamic> json){
    var jsonArray = json ["post1_wrap"] as List;
    List<Cities> citiesList = jsonArray.map((jsonArrayNesnesi) => Cities.fromJson(jsonArrayNesnesi)).toList();

    return CitiesReturn(json["success"] as int, citiesList);
  }
}