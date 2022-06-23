import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:focaburada/pages/CatPage.dart';
import 'package:focaburada/pages/DetaySayfa.dart';
import 'package:focaburada/pages/DetaySayfaCat.dart';
import 'package:focaburada/pages/DetaySayfaCity.dart';
import 'package:focaburada/pages/ilanlar.dart';
import 'package:focaburada/theme/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focaburada/widgets/CarouselSlider.dart';
import 'data/Categories.dart';
import 'data/CategoriesReturn.dart';
import 'data/Cities.dart';
import 'data/CitiesReturn.dart';
import 'data/Companies.dart';
import 'data/CompaniesReturn.dart';
import 'data/chats_json.dart';
import 'main.dart';
import 'pages/home.dart';
import 'pages/profil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  List<Companies> parseCompaniesReturn(String cevap){
    return CompaniesReturn.fromJson(json.decode(cevap)).companiesList;
  }

  Future<List<Companies>> allCompanies() async {
    var url = Uri.parse("https://focaburada.com/api/tum_ilceler.php");
    var cevap = await http.get(url);
    return parseCompaniesReturn(cevap.body);
  }
  Future<List<Companies>> aramaYap(String aramaKelimesi) async {
    var url = Uri.parse("https://focaburada.com/api/tum_arama.php");
    var veri = {"isletme_adi":aramaKelimesi};
    var cevap = await http.post(url,body: veri);
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

  List<Cities> parseCitiesReturn(String cevap){
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
        title: aramaYapiliyorMu ?
        TextField(
          decoration: InputDecoration(hintText: "Arama için birşey yazın"),
          onChanged: (aramaSonucu){
            print("Arama sonucu : $aramaSonucu");
            setState(() {
              aramaKelimesi = aramaSonucu;
            });
          },
        )
            : Image.asset('images/logooval.png', fit: BoxFit.contain,height: 55,),
        actions: [
          aramaYapiliyorMu ?
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: (){
              setState(() {
                aramaYapiliyorMu = false;
                aramaKelimesi = "";
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                aramaYapiliyorMu = true;
              });
            },
          ),
        ],
        actionsIconTheme: const IconThemeData(size: 32,),

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

                          image: NetworkImage(
                              "https://focaburada.com/doc/logooval.png"),
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
                    builder: (context) =>  ChatPage(),
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
      bottomNavigationBar: getFooter(),

    );
  }

  Widget getFooter(){

    return BottomAppBar(

      child: Row(
        children: [
          Expanded(

            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top:5.0,bottom:5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: 30,
                        width: 20,
                        child: Image.network('https://cdn-icons-png.flaticon.com/512/845/845022.png', fit: BoxFit.contain,)
                    ),
                    Container(
                      child:  Text('İşletmeler', style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600, color: black)),
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
                padding: const EdgeInsets.only(top:5.0,bottom:5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: 30,
                        width: 20,
                        child: Image.network('https://cdn-icons-png.flaticon.com/512/942/942833.png', fit: BoxFit.contain,)
                    ),
                    Container(
                      child:  Text('İş İlanları', style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600, color: black)),
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
                padding: const EdgeInsets.only(top:5.0,bottom:5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: 30,
                        width: 20,
                        child: Image.network('https://focaburada.com/static/img/category.png', fit: BoxFit.contain,)
                    ),
                    Container(
                      child:  Text('Kategoriler', style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600, color: black)),
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
    return ListView(
      children: [
        const  SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Kategoriler",
                 style: GoogleFonts.montserrat (textStyle: const TextStyle(
    fontSize: 18, fontWeight: FontWeight.w500, color: black)),),
            ),
            const   SizedBox(
              height: 5,
            ),
            Divider(height: 2),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top:0,left: 15),
                child: Column(
                  children:[
                    SizedBox(
                        width: 1970,
                        height: 105,
                        child: Stack(
                          children: [
                            Container(
                              child: FutureBuilder<List<Categories>>(
                                future: allCategories(),
                                builder: (context,snapshot){
                                  if(snapshot.hasData){
                                    var categoriesList = snapshot.data;
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: categoriesList.length,
                                      itemBuilder: (context,indeks){
                                        var category = categoriesList[indeks];
                                        return GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfaCat(category: category,)));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                    width: 70,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage('https://focaburada.com/doc/post1/${category.file2}'),
                                                            fit: BoxFit.cover))
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  width: 70,
                                                  child: Align(
                                                      child: Text(
                                                        category.wrap_name,
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                                                      )),
                                                )
                                              ],

                                            ),
                                          ),

                                        );
                                      },
                                    );
                                  }else{
                                    return Center();
                                  }
                                },
                              ),
                            )
                          ],
                        )
                    ),

                  ],
                ),
              ),
            ),

             Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Semtler",
    style: GoogleFonts.montserrat (textStyle: const TextStyle(
    fontSize: 18, fontWeight: FontWeight.w500, color: black)),),
            ),

            const   SizedBox(
              height: 5,
            ),
            Divider(height: 2),

            const   SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top:0,left: 15),
                child: Column(
                  children:[
                    SizedBox(
                        width: 770,
                        height: 125,
                        child: Stack(
                          children: [
                            Container(
                              child: FutureBuilder<List<Cities>>(
                                future: allCities(),
                                builder: (context,snapshot){
                                  if(snapshot.hasData){
                                    var citiesList = snapshot.data;
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: citiesList.length,
                                      itemBuilder: (context,indeks){
                                        var city = citiesList[indeks];
                                        return GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfaCity(city: city,)));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      child: Image.network( 'https://focaburada.com/doc/post1/${city.file2}', fit: BoxFit.cover,)

                                                  ),
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
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                                                      )),
                                                )
                                              ],

                                            ),
                                          ),

                                        );
                                      },
                                    );
                                  }else{
                                    return Center();
                                  }
                                },
                              ),
                            )
                          ],
                        )
                    ),

                  ],
                ),
              ),
            ),

             Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Son Eklenen İşletmeler",
                style: GoogleFonts.montserrat (textStyle: const TextStyle(
    fontSize: 18, fontWeight: FontWeight.w500, color: black)),
              ),
            ),
            const   SizedBox(
              height: 5,
            ),
            Divider(height: 2),

              FutureBuilder<List<Companies>>(
                future: aramaYapiliyorMu ? aramaYap(aramaKelimesi): allCompanies(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    var companiesList = snapshot.data;
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, indeks){
                        var companies = companiesList[indeks];
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(company: companies,)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left:15, right:15,top: 10, bottom: kFloatingActionButtonMargin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Container(
                                  height:75,
                                  width:75,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://focaburada.com/doc/company/${companies.file1 == null ? "0.png" : companies.file1}"),

                                          fit: BoxFit.fill
                                      )
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Wrap(
                                        direction: Axis.horizontal, //Vertical || Horizontal

                                        children: [
                                        SizedBox(
                                        width: 250,
                                          child: Text( companies.isletme_adi,
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,  color: Colors.black,),),
                                        ),

                                        ],
                                      ),

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
                                      height: 5,
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

}
