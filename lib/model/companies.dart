import 'dart:convert';
import 'package:focaburada/model/location_model.dart';

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
  List<String> galeri;
  String semt_adi;
  LocationModel locationModel;

  Companies({
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
    this.locationModel,
  });

  factory Companies.fromJson(Map<String, dynamic> json) {
    LocationModel locationModel;
    List<String> gallery = [];

    if (json['map_data'] != null) {
      try {
        Map<String, dynamic> _mapDataJson = jsonDecode(json['map_data'])[0];

        locationModel = LocationModel.fromJson(_mapDataJson);
      } catch (e) {
        locationModel = null;
      }
    }

    List _gallery;

    try {
      _gallery = json["galeri"] as List;
    } catch (e) {
      _gallery = [json["galeri"]];
    }

    if (_gallery != null) {
      _gallery.forEach((imageName) {
        if (imageName is String) {
          gallery.add(imageName);
        }
      });
    }

    return Companies(
      company_id: json["company_id"] as String,
      yetkili_isim: json["yetkili_isim"] as String,
      yetkili_telefon: json["yetkili_telefon"] as String,
      isletme_resmi_ad: json["isletme_resmi_ad"] as String,
      vergi_no: json["vergi_no"] as String,
      telefon: json["telefon"] as String,
      file1: json["file1"] as String,
      isletme_adi: json["isletme_adi"] as String,
      hakkimizda: json["hakkimizda"] as String,
      calisma_saatleri: json["calisma_saatleri"] as String,
      adres: json["adres"] as String,
      duyuru_baslik: json["duyuru_baslik"] as String,
      social_instagram: json["social_instagram"] as String,
      social_facebook: json["social_facebook"] as String,
      kategori_adi: json["kategori_adi"] as String,
      galeri: gallery,
      semt_adi: json["semt_adi"] as String,
      locationModel: locationModel,
    );
  }
}
