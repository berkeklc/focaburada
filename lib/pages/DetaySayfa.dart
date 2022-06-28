import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focaburada/model/companies.dart';
import 'package:flutter/material.dart';
import 'package:focaburada/modules/lightbox_images/lightbox_images.dart';
import 'package:focaburada/modules/lightbox_images/lightbox_images_controller.dart';
import 'package:focaburada/services/map_service.dart';
import 'package:focaburada/widgets/company_menus_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../theme/colors.dart';
import '../widgets/CarouselSlider.dart';

class DetaySayfa extends StatefulWidget {
  Companies company;

  DetaySayfa({this.company});

  @override
  _DetaySayfaState createState() => _DetaySayfaState();
}

final List<String> DaysList = [
  'Pazartesi',
  'Salı',
  'Çarşamba',
  'Perşembe',
  'Cuma',
  'Cumartesi',
  'Pazar',
];

final List<String> textList = [
  'Merkez',
  'Yenifoça',
  'Bağarası',
  'Yenibağarası',
  'Gerenköy',
  'Kozbeyli',
  'Yeniköy',
  'Ilıpınar',
  'Kocamehmetler',
];

class Calisma_saatleri {
  String start;
  String end;
  int close;

  Calisma_saatleri({this.start, this.end, this.close});

  Calisma_saatleri.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    close = json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['start'] = start;
    data['end'] = end;
    data['close'] = close;
    return data;
  }
}

List<Calisma_saatleri> wrktimesFromJson(String str) =>
    List<Calisma_saatleri>.from(
        jsonDecode(str).map((x) => Calisma_saatleri.fromJson(x)));

class _DetaySayfaState extends State<DetaySayfa> {
  int pageIndex = 0;
  List<Calisma_saatleri> worktimes = [];

  final LightBoxImagesPresenter lightboxController = LightBoxImagesPresenter();

  @override
  void initState() {
    worktimes = wrktimesFromJson(widget.company.calisma_saatleri.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> _companyImages() {
      return widget.company.galeri
          .map((imageName) => 'https://focaburada.com/doc/galeri/$imageName')
          .toList();
    }

    final List<String> imgList = [
      'https://focaburada.com/doc/company/${widget.company.file1 == null ? "0.png" : widget.company.file1}',
      ..._companyImages(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.blueAccent),
        title: Image.asset(
          'images/logooval.png',
          fit: BoxFit.contain,
          height: 55,
        ),
      ),
      bottomNavigationBar: getFooter(),
      body: LightBoxImages(
        controller: lightboxController,
        imageUrls: imgList,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Stack(
                  children: [
                    ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://focaburada.com/doc/company/${widget.company.file1 == null ? "0.png" : widget.company.file1}',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                      ),
                    ),
                    Positioned(
                      child: Container(
                        width: 500,
                        height: 390.0,
                        decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 5),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: const EdgeInsets.only(
                                bottom: 55, // Space between underline and text
                              ),
                              child: Text(
                                widget.company.isletme_adi.toString(),
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.only(
                            bottom: 5, // Space between underline and text
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.facebook,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    print(widget.company.social_instagram
                                        .toString());
                                    launchUrl(
                                      Uri.parse(widget.company.social_facebook),
                                      mode: LaunchMode.externalApplication,
                                    );
                                    print("Pressed");
                                  }),
                              IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.instagram,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    print(widget.company.social_instagram
                                        .toString());
                                    launchUrl(
                                      Uri.parse(
                                          widget.company.social_instagram),
                                      mode: LaunchMode.externalApplication,
                                    );
                                    print("Pressed");
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 5),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.only(
                            bottom: 235,
                            left: 0, // Space between underline and text
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 10.0,
                                  bottom: 10,
                                ),
                                padding: const EdgeInsets.only(
                                    left: 15, bottom: 7, top: 7, right: 15),
                                child: Container(
                                  child: Text(
                                    widget.company.semt_adi.toString(),
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10,
                                ),
                                padding: const EdgeInsets.only(
                                    left: 15, bottom: 7, top: 7, right: 15),
                                child: Container(
                                  child: Text(
                                    widget.company.kategori_adi.toString(),
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 5,
                  top: 10,
                  bottom: 5,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: const Text(
                      'Hakkımızda ',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      widget.company.hakkimizda.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              CompanyMenusWidget(
                company: widget.company,
              ),
              Divider(
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Colors.blueAccent,
                height: 15,
              ),
              Row(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 15, top: 0, right: 0, bottom: 5),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.phone,
                          size: 24.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Telefon ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 6, right: 0, bottom: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              widget.company.telefon.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  MapService.instance
                      .launchDirections(widget.company.locationModel);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 15, top: 0, right: 0, bottom: 5),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.transparent,
                        child: IconButton(
                          icon: Icon(
                            Icons.location_on,
                            size: 24.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Adres ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 40, top: 2, right: 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                widget.company.adres.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Colors.blueAccent,
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /**    const Padding(
                    padding: EdgeInsets.only(left: 15, top:5,right: 5,bottom:5),

                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.access_time_rounded,
                          size: 24.0,
                          color: Colors.blueAccent,
                        ),

                      ),
                    ),

                  ),
                    Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6, top: 15, right: 5, bottom: 5),
                          child: Column(
                            children: worktimes?.map((worktime) {
                              return Text(
                                "Açılış : ${worktime.start ?? "-"} / Kapanış : ${worktime.end ?? "-"}",
                                style: const TextStyle(fontSize: 16),
                              );
                            })?.toList() ?? [],
                          ),
                        ),
                      ),
                    ],
                  ), **/
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20.0, left: 100, right: 100, top: 15),
                child: Column(
                  children: [
                    Container(
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: const Text("İşletmeyi Ara"),
                              onPressed: () async {
                                FlutterPhoneDirectCaller.callNumber(
                                    '${widget.company.telefon}');
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blueAccent,
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                      height: 36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    if (widget.company.locationModel != null)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    child: const Text("Yol Tarifi"),
                                    onPressed: () async {
                                      MapService.instance.launchDirections(
                                          widget.company.locationModel);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Container(
                  child: CarouselSlider.builder(
                options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                ),
                itemCount: (imgList.length / 2).round(),
                itemBuilder: (context, index, realIdx) {
                  final int first = index * 2;
                  final int second = first + 1;
                  return Row(
                    children: [first, second].map((i) {
                      return Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                lightboxController.openImageURL(imgList[i]);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: PinchZoom(
                                  child: CachedNetworkImage(
                                    imageUrl: imgList[i],
                                    fit: BoxFit.cover,
                                  ),
                                  resetDuration:
                                      const Duration(milliseconds: 100),
                                  maxScale: 2.5,
                                  onZoomStart: () {
                                    print('Start zooming');
                                  },
                                  onZoomEnd: () {
                                    print('Stop zooming');
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFooter() {
    List bottomItems = [
      pageIndex == 0 ? "images/home.svg" : "images/home.svg",
      pageIndex == 1 ? "images/cvs.svg" : "images/cvs.svg",
      pageIndex == 2 ? "images/profil.svg" : "images/profil.svg",
    ];
  }
}
