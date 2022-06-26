import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:focaburada/model/companies_pagination_options.dart';
import 'package:focaburada/modules/home/home_page_presenter.dart';
import 'package:focaburada/pages/CatPage.dart';
import 'package:focaburada/pages/DetaySayfa.dart';
import 'package:focaburada/pages/DetaySayfaCat.dart';
import 'package:focaburada/pages/DetaySayfaCity.dart';
import 'package:focaburada/pages/ilanlar.dart';
import 'package:focaburada/theme/colors.dart';
import 'package:focaburada/widgets/app_drawer.dart';
import 'package:focaburada/widgets/company_item_widget.dart';
import '../../data/Categories.dart';
import '../../data/CategoriesReturn.dart';
import '../../data/Cities.dart';
import '../../data/CitiesReturn.dart';
import '../../model/companies.dart';
import '../../data/CompaniesReturn.dart';
import '../../main.dart';
import '../../pages/profil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomePageContract {
  HomePagePresenter _presenter;

  final ScrollController _scrollController = ScrollController();

  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  bool companiesNextPageLoading = false;

  List<Companies> companies = [];

  @override
  void initState() {
    super.initState();
    _presenter = HomePagePresenter(this);
    _presenter.getCompanies();
  }

  List<Companies> parseCompaniesReturn(String cevap) {
    return CompaniesReturn.fromJson(json.decode(cevap)).companiesList;
  }

  List<Categories> parseCategoriesReturn(String cevap) {
    return CategoriesReturn.fromJson(json.decode(cevap)).categoriesList;
  }

  Future<List<Categories>> allCategories() async {
    var url = Uri.parse("https://focaburada.com/api/tum_category.php");
    var cevap = await http.get(url);
    return parseCategoriesReturn(cevap.body);
  }

  List<Cities> parseCitiesReturn(String cevap) {
    return CitiesReturn.fromJson(json.decode(cevap)).citiesList;
  }

  Future<List<Cities>> allCities() async {
    var url = Uri.parse("https://focaburada.com/api/tum_ilce.php");
    var cevap = await http.get(url);
    return parseCitiesReturn(cevap.body);
  }

  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final TextStyle display1 = Theme.of(context).textTheme.headline4;

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
                onSubmitted: (value) => _presenter.search(value),
              )
            : Image.asset(
                'images/logooval.png',
                fit: BoxFit.contain,
                height: 55,
              ),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    _presenter.getCompanies(resetPage: true);

                    setState(() {
                      aramaYapiliyorMu = false;
                      aramaKelimesi = "";
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                ),
        ],
        actionsIconTheme: const IconThemeData(
          size: 32,
        ),
      ),
      drawer: AppDrawer(),
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
                        imageUrl:
                            'https://cdn-icons-png.flaticon.com/512/845/845022.png',
                        fit: BoxFit.contain,
                      ),
                    ),
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
                          imageUrl:
                              'https://cdn-icons-png.flaticon.com/512/942/942833.png',
                          fit: BoxFit.contain,
                        )),
                    Container(
                      child: Text(
                        'İş İlanları',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: black,
                        ),
                      ),
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
                          imageUrl:
                              'https://focaburada.com/static/img/category.png',
                          fit: BoxFit.contain,
                        )),
                    Container(
                      child: Text('Kategoriler',
                          style: const TextStyle(
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
    final TextStyle display1 = Theme.of(context).textTheme.headline4;

    var size = MediaQuery.of(context).size;
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (!notification.metrics.atEdge) return true;

        if (notification.metrics.pixels != 0) {
          _presenter.getCompanies();
        }

        return true;
      },
      child: ListView(
        controller: _scrollController,
        children: [
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Kategoriler",
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: black)),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(height: 2),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 15),
                  child: Column(
                    children: [
                      SizedBox(
                          width: 1970,
                          height: 105,
                          child: Stack(
                            children: [
                              Container(
                                child: FutureBuilder<List<Categories>>(
                                  future: allCategories(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var categoriesList = snapshot.data;
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: categoriesList.length,
                                        itemBuilder: (context, indeks) {
                                          var category = categoriesList[indeks];
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetaySayfaCat(
                                                    category: category,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 70,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: CachedNetworkImageProvider(
                                                            'https://focaburada.com/doc/post1/${category.file2}'),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    width: 70,
                                                    child: Align(
                                                        child: Text(
                                                      category.wrap_name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return Center();
                                    }
                                  },
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Semtler",
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: black)),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(height: 2),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 15),
                  child: Column(
                    children: [
                      SizedBox(
                          width: 770,
                          height: 125,
                          child: Stack(
                            children: [
                              Container(
                                child: FutureBuilder<List<Cities>>(
                                  future: allCities(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var citiesList = snapshot.data;
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: citiesList.length,
                                        itemBuilder: (context, indeks) {
                                          var city = citiesList[indeks];
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetaySayfaCity(
                                                            city: city,
                                                          )));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              'https://focaburada.com/doc/post1/${city.file2}',
                                                          fit: BoxFit.cover,
                                                        )),
                                                    width: 70,
                                                    height: 85,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    width: 70,
                                                    child: Align(
                                                        child: Text(
                                                      city.wrap_name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return Center();
                                    }
                                  },
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Son Eklenen İşletmeler",
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(height: 2),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  Widget content = CompanyItemWidget(company: companies[i]);

                  bool isLastItem = i == companies.length - 1;

                  if (isLastItem && companiesNextPageLoading) {
                    return Column(
                      children: [
                        content,
                        Center(
                          child: Container(
                            height: 36,
                            width: 36,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    );
                  }

                  return content;
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 1);
                },
                itemCount: companies.length,
                shrinkWrap: true,
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  onCategoriesUpdate(List<Categories> _categories) {
    // TODO: implement onCategoriesUpdate
    throw UnimplementedError();
  }

  @override
  onCitiesUpdate(List<Cities> _cities) {
    // TODO: implement onCitiesUpdate
    throw UnimplementedError();
  }

  @override
  onCompaniesUpdate(List<Companies> _companies) {
    setState(() {
      companies.addAll(_companies);
    });
  }

  @override
  onSearchResultUpdate(List<Companies> _companies) {
    setState(() {
      companies = _companies;
    });
  }

  @override
  onCompaniesLoading(bool _newValue) {
    setState(() {
      companiesNextPageLoading = _newValue;
    });
  }
}
