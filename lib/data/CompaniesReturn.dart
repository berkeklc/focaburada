import 'package:focaburada/model/companies.dart';

class CompaniesReturn{
  int success;
  List<Companies> companiesList;

  CompaniesReturn(this.success, this.companiesList);
  factory CompaniesReturn.fromJson(Map<String,dynamic> json){
    var jsonArray = json ["company"] as List;
    List<Companies> companiesList = jsonArray.map((jsonArrayNesnesi) => Companies.fromJson(jsonArrayNesnesi)).toList();

    return CompaniesReturn(json["success"] as int, companiesList);
  }
}