import 'package:flutter/material.dart';
import 'package:focaburada/pages/CatPage.dart';
import 'package:focaburada/pages/profil.dart';
import 'package:focaburada/theme/colors.dart';
import 'package:focaburada/data/likes_json.dart';
import '../data/Cvs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../data/CvsReturn.dart';
import '../home_page.dart';
import '../main.dart';
import 'DetaySayfailan.dart';


class IlanlarPage extends StatefulWidget {

  @override
  _IlanlarPageState createState() => _IlanlarPageState();
}

class _IlanlarPageState extends State<IlanlarPage>
    with TickerProviderStateMixin {
  List<Cvs> parseCvsReturn(String cevap){
    return CvsReturn.fromJson(json.decode(cevap)).cvsList;
  }

  Future<List<Cvs>> allCvs() async {
    var url = Uri.parse("https://focaburada.com/api/tum_ilanlar.php");
    var cevap = await http.get(url);
    return parseCvsReturn(cevap.body);
  }
  List itemsTemp = [];
  int itemLength = 0;
  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";
  @override


  @override
  Widget build(BuildContext context) {
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
                      child:  Text('Kategoriler', style: TextStyle(
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
    var size = MediaQuery.of(context).size;

    return ListView(

      children: [

        const  SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(
              height: 5,
            ),

            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Son Eklenen İş İlanları",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600, color: black),
              ),
            ),
            const   SizedBox(
              height: 5,
            ),
            Divider(height: 2),
            const   SizedBox(
              height: 15,
            ),
            FutureBuilder<List<Cvs>>(

              future: allCvs(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  var cvsList = snapshot.data;
                  return ListView.builder(

                    itemCount: cvsList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,indeks){
                      var cvs = cvsList[indeks];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfailan(ilan: cvs)));
                        },
                        child: Padding(padding: const EdgeInsets.only(left:5, right:5, bottom: kFloatingActionButtonMargin) ,
                          child: Wrap (

                            spacing: 5,
                            runSpacing: 10,
                            children: [
                              SizedBox(

                                width: (size.width - 15) / 1,
                                child: Stack(
                                  children: [

                                    Container(
                                      margin: const EdgeInsets.all(10.0),
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15.0) //                 <--- border radius here
                                          )
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(10.0),
                                              child: Align(
                                                  alignment: Alignment.bottomLeft,
                                                  child: Text(
                                                    cvs.isletme_adi,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          Divider(height: 2),

                                          Row(

                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(left: 5, top:5,right: 5,bottom:5),

                                                child: Icon(

                                                  Icons.phone,
                                                  color: Colors.black,
                                                  size: 16.0,
                                                  semanticLabel: 'Text to announce in accessibility modes',
                                                ),

                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0, top:5,right: 5,bottom:5),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Container(
                                                    child: Text(cvs.telefon.toString(),style: TextStyle(fontSize: 18),),

                                                  ),
                                                ),

                                              ),

                                            ],

                                          ),
                                          SizedBox(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 6, bottom: 8),
                                              child: Align(
                                                  alignment: Alignment.bottomLeft,
                                                  child: Text(
                                                    cvs.hakkimizda,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: black,
                                                      fontSize: 16,
                                                    ),
                                                  )),
                                            ),
                                          ),

                                        ],
                                      ),

                                    ),
                                    const   SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),

                              ),
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
          ],
        )
      ],
    );
  }
}