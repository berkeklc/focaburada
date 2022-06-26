import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:focaburada/pages/CatPage.dart';
import 'package:focaburada/pages/DetaySayfa.dart';
import 'package:focaburada/pages/DetaySayfaCat.dart';
import 'package:focaburada/pages/ilanlar.dart';
import 'package:focaburada/theme/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focaburada/widgets/CarouselSlider.dart';
import 'package:focaburada/data/Categories.dart';
import 'package:focaburada/data/CategoriesReturn.dart';
import 'package:focaburada/model/companies.dart';
import 'package:focaburada/data/CompaniesReturn.dart';
import 'package:focaburada/data/chats_json.dart';
import 'package:focaburada/main.dart';
import 'package:focaburada/pages/home.dart';
import 'package:focaburada/pages/profil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modules/home/home_page.dart';

class CatPage extends StatefulWidget {
  @override
  _CatPageState createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  List<Companies> parseCompaniesReturn(String cevap) {
    return CompaniesReturn.fromJson(json.decode(cevap)).companiesList;
  }

  Future<List<Companies>> allCompanies() async {
    var url = Uri.parse("https://focaburada.com/api/tum_ilceler.php");
    var cevap = await http.get(url);
    return parseCompaniesReturn(cevap.body);
  }

  List<Categories> parseCategoriesReturn(String cevap) {
    return CategoriesReturn.fromJson(json.decode(cevap)).categoriesList;
  }

  Future<List<Categories>> allCategories() async {
    var url = Uri.parse("https://focaburada.com/api/tum_category.php");
    var cevap = await http.get(url);
    return parseCategoriesReturn(cevap.body);
  }

  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.blueAccent),
        title: aramaYapiliyorMu
            ? TextField(
                decoration:
                    InputDecoration(hintText: "Arama için birşey yazın"),
                onChanged: (aramaSonucu) {
                  print("Arama sonucu : $aramaSonucu");
                  setState(() {
                    aramaKelimesi = aramaSonucu;
                  });
                },
              )
            : Image.asset(
                'images/logooval.png',
                fit: BoxFit.contain,
                height: 55,
              ),
        actions: [],
        actionsIconTheme: const IconThemeData(
          size: 32,
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blueAccent, Colors.lightBlueAccent])),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 55,
                  bottom: 25,
                ),
                child: Container(
                  width: 93,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: CachedNetworkImageProvider(
                            "https://focaburada.com/doc/logooval.png",
                          ),
                          fit: BoxFit.contain)),
                ),
              ),
            ),
            ListTile(
              title: const Text('Profilim'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('İşletmeler'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('İş İlanları'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IlanlarPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Çıkış Yap'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getFooter() {
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: 30,
                        width: 20,
                        child: CachedNetworkImage(
                          imageUrl: 'https://cdn-icons-png.flaticon.com/512/845/845022.png',
                          fit: BoxFit.contain,
                        )),
                    Container(
                      child: Text('İşletmeler',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: black)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IlanlarPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: 30,
                        width: 20,
                        child: CachedNetworkImage(
                          imageUrl: 'https://cdn-icons-png.flaticon.com/512/942/942833.png',
                          fit: BoxFit.contain,
                        )),
                    Container(
                      child: Text('İş İlanları',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: black)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: 30,
                        width: 20,
                        child: CachedNetworkImage(
                          imageUrl: 'https://focaburada.com/static/img/category.png',
                          fit: BoxFit.contain,
                        )),
                    Container(
                      child: Text('Kategoriler',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: black)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return ListView(
      children: [
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Kategoriler",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600, color: black),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Divider(height: 2),
            FutureBuilder<List<Categories>>(
              future: allCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var categoriesList = snapshot.data;
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, indeks) {
                      var category = categoriesList[indeks];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetaySayfaCat(
                                        category: category,
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 10,
                              bottom: kFloatingActionButtonMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            "https://focaburada.com/doc/post1/${category.file2 == null ? "0.png" : category.file2}"),
                                        fit: BoxFit.fill)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Wrap(
                                      direction: Axis
                                          .horizontal, //Vertical || Horizontal

                                      children: [
                                        SizedBox(
                                          width: 250,
                                          child: Text(
                                            category.wrap_name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(height: 1);
                    },
                    itemCount: categoriesList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(5),
                    scrollDirection: Axis.vertical,
                  ); //
                } else {
                  return Center();
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
