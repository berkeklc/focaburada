import 'package:focaburada/data/Cvs.dart';

class CvsReturn{
  int success;
  List<Cvs> cvsList;

  CvsReturn(this.success, this.cvsList);
  factory CvsReturn.fromJson(Map<String,dynamic> json){
    var jsonArray = json ["ilan"] as List;
    List<Cvs> cvsList = jsonArray.map((jsonArrayNesnesi) => Cvs.fromJson(jsonArrayNesnesi)).toList();

    return CvsReturn(json["success"] as int, cvsList);
  }
}