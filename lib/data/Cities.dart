import 'package:focaburada/model/companies.dart';

class Cities {
  String wrap_id;
  String data_type;
  String wrap_name;
  String parent_id;
  String name;
  String title;
  String content;
  String file1;
  String file2;

  Cities
      (this.wrap_id, this.data_type, this.wrap_name,
      this.parent_id, this.name, this.title, this.content,  this.file1, this.file2,
      );

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      json["wrap_id"] as String,
      json["data_type"] as String,
      json["wrap_name"] as String,
      json["parent_id"] as String,
      json["name"] as String,
      json["title"] as String,
      json["content"] as String,
      json["file1"] as String,
      json["file2"] as String,
    );
  }
}