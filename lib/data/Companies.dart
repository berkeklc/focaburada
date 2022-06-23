import 'package:focaburada/data/Categories.dart';
import 'package:focaburada/data/Cities.dart';

class Companies {
  String company_id;
  String yetkili_isim;
  String yetkili_telefon;
  String isletme_resmi_ad;
  String vergi_no;
  String telefon;
  String file1;
  String isletme_adi;
  String hakkimizda;
  String calisma_saatleri;
  String adres;
  String duyuru_baslik;
  String social_instagram;
  String social_facebook;
  String kategori_adi;
  String galeri;
  String semt_adi;
  Companies(
      this.company_id,
      this.yetkili_isim,
      this.yetkili_telefon,
      this.isletme_resmi_ad,
      this.vergi_no,
      this.telefon,
      this.file1,
      this.isletme_adi,
      this.hakkimizda,
      this.calisma_saatleri,
      this.adres,
      this.duyuru_baslik,
      this.social_instagram,
      this.social_facebook,
      this.kategori_adi,
      this.galeri,
      this.semt_adi,
      );

  factory Companies.fromJson(Map<String, dynamic> json) {
    return Companies(
      json["company_id"] as String,
      json["yetkili_isim"] as String,
      json["yetkili_telefon"] as String,
      json["isletme_resmi_ad"] as String,
      json["vergi_no"] as String,
      json["telefon"] as String,
      json["file1"] as String,
      json["isletme_adi"] as String,
      json["hakkimizda"] as String,
      json["calisma_saatleri"] as String,
      json["adres"] as String,
      json["duyuru_baslik"] as String,
      json["social_instagram"] as String,
      json["social_facebook"] as String,
      json["kategori_adi"] as String,
      json["galeri"] as String,
      json["semt_adi"] as String,
    );
  }
}