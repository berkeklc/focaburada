import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focaburada/pages/profil.dart';
import 'package:focaburada/theme/colors.dart';
import 'package:focaburada/data/chats_json.dart';
import '../data/Categories.dart';
import '../data/CategoriesReturn.dart';
import '../model/companies.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../data/CompaniesReturn.dart';
import '../main.dart';
import '../widgets/CarouselSlider.dart';
import 'DetaySayfa.dart';
import 'ilanlar.dart';

class ExplorePage extends StatefulWidget {

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {

  List<Companies> parseCompaniesReturn(String cevap){
    return CompaniesReturn.fromJson(json.decode(cevap)).companiesList;
  }

  Future<List<Companies>> allCompanies() async {
    var url = Uri.parse("https://focaburada.com/api/tum_ilceler.php");
    var cevap = await http.get(url);
    return parseCompaniesReturn(cevap.body);
  }

  List<Categories> parseCategoriesReturn(String cevap){
    return CategoriesReturn.fromJson(json.decode(cevap)).categoriesList;
  }

  Future<List<Categories>> allCategories() async {
    var url = Uri.parse("https://focaburada.com/api/tum_category.php");
    var cevap = await http.get(url);
    return parseCategoriesReturn(cevap.body);
  }

  List itemsTemp = [];
  int itemLength = 0;
  @override
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        iconTheme: IconThemeData(color: Colors.blueAccent),
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
                padding: const EdgeInsets.only(left: 10, right: 10, top: 55, bottom: 25,),
                child: Container(
                  width: 93,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(

                          image: CachedNetworkImageProvider(
                              "https://focaburada.com/doc/focalogo.jpg"),
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
                    builder: (context) =>  ProfPage(),
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
                    builder: (context) =>  ExplorePage(),
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
                    builder: (context) =>  IlanlarPage(),
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
                    builder: (context) =>  LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return ListView(

      children: [

        const  SizedBox(
          height: 10,
        ),

        const  SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(

                    children: List.generate(chats_json.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right:2),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: Stack(
                                children: <Widget>[
                                  chats_json[index]['story']
                                      ? Container(

                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    chats_json[index]['img']),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  )
                                      : Container(
                                    width: 55,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                chats_json[index]['img']),
                                            fit: BoxFit.cover)),
                                  ),
                                  chats_json[index]['online']
                                      ? Positioned(
                                    top: 48,
                                    left: 52,
                                    child: Container(
                                      width: 10,
                                      height:20,
                                      decoration: BoxDecoration(
                                          color: green,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: white, width: 3)),
                                    ),
                                  )
                                      : Container()
                                ],
                              ),
                            ),
                            const    SizedBox(
                              height: 2,
                            ),
                            SizedBox(
                              width: 70,
                              child: Align(
                                  child: Text(

                                    chats_json[index]['name'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10),
                                  )),
                            )
                          ],
                        ),
                      );
                    }) //**
                ),
              ),
            ),
            const   SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Semtler",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600, color: black),
              ),
            ),
            const   SizedBox(
              height: 10,
            ),

            const   SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Son Eklenen İşletmeler",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600, color: black),
              ),
            ),
            const   SizedBox(
              height: 5,
            ),
             Divider(height: 1),
            const   SizedBox(
              height: 15,
            ),

            FutureBuilder<List<Companies>>(

              future: allCompanies(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  var companiesList = snapshot.data;
                  return ListView.separated(
                    itemBuilder: (context, indeks){
                      var companies = companiesList[indeks];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(company: companies,)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left:15, right:15, bottom: kFloatingActionButtonMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height:75,
                                width:75,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            "https://focaburada.com/doc/company/${companies.file1}"),
                                        fit: BoxFit.fill
                                    )
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text( companies.isletme_adi,  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,  color: Colors.black,),),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text( companies.semt_adi,),
                                  ),
                                  const   SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10.0,),
                                    color: Colors.blue,
                                    padding: const EdgeInsets.only(top:3, left:10,right:10, bottom:3,),
                                    child: Text(companies.kategori_adi, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,  color: Colors.white,),
                                    ),),
                                  const   SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),

                            ],
                          ),

                        ),
                      );
                    },
                    separatorBuilder: (context,index)
                    {

                      return Divider(height: 1);

                    },
                    itemCount: companiesList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(5),
                    scrollDirection: Axis.vertical,
                  );//
                }else{
                  return Center();
                }
              },
            ),

          ],
        )
      ],
    );
  }
  Widget getFooter(){
    List bottomItems = [
      pageIndex == 0
          ? "images/home.svg"
          : "images/home.svg",
      pageIndex == 1
          ? "images/cvs.svg"
          : "images/cvs.svg",
      pageIndex == 2
          ? "images/profil.svg"
          : "images/profil.svg",
    ];
    return BottomAppBar(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 2.0, color: Colors.lightBlue.shade600),
          ),
        ),

        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children:

          List.generate(bottomItems.length, (index) {
            return IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = index;
                });
              },
              icon: SvgPicture.asset(
                bottomItems[index],
              ),
            );
          }),
        ),
      ),
    );
  }

}