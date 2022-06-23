class Cvs {
  String ilan_id;
  String yetkili_isim;
  String yetkili_telefon;
  String isletme_resmi_ad;
  String vergi_no;
  String calisma_saatleri;
  String telefon;
  String file1;
  String isletme_adi;
  String hakkimizda;
  String adres;

  Cvs(
      this.ilan_id,
      this.yetkili_isim,
      this.yetkili_telefon,
      this.isletme_resmi_ad,
      this.vergi_no,
      this.calisma_saatleri,
      this.telefon,
      this.file1,
      this.isletme_adi,
      this.hakkimizda,
      this.adres,

      );

  factory Cvs.fromJson(Map<String, dynamic> json) {
    return Cvs(
      json["ilan_id"] as String,
      json["calisma_saatleri"] as String,
      json["yetkili_isim"] as String,
      json["yetkili_telefon"] as String,
      json["isletme_resmi_ad"] as String,
      json["vergi_no"] as String,
      json["telefon"] as String,
      json["file1"] as String,
      json["isletme_adi"] as String,
      json["hakkimizda"] as String,
      json["adres"] as String,

    );
  }
}