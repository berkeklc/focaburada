import 'package:cached_network_image/cached_network_image.dart';
import 'package:focaburada/pages/DetaySayfa.dart';
import 'package:focaburada/model/companies.dart';
import 'package:focaburada/data/CompaniesReturn.dart';
import 'package:focaburada/data/Categories.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../theme/colors.dart';

class DetaySayfaCat extends StatefulWidget {
  Categories category;

  DetaySayfaCat({this.category});

  @override
  _DetaySayfaCatState createState() => _DetaySayfaCatState();
}
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
    List<Calisma_saatleri>.from(jsonDecode(str).map((x) => Calisma_saatleri.fromJson(x)));
class _DetaySayfaCatState extends State<DetaySayfaCat> {
  List<Calisma_saatleri> worktimes = []; bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";
  Future<List<Companies>> aramaYap(String aramaKelimesi) async {
    var url = Uri.parse("https://focaburada.com/api/tum_arama.php");
    var veri = {"isletme_adi":aramaKelimesi};
    var cevap = await http.post(url,body: veri);
    return parseCompaniesReturn(cevap.body);
  }
  List<Companies> parseCompaniesReturn(String cevap){
    return CompaniesReturn.fromJson(json.decode(cevap)).companiesList;
  }

  Future<List<Companies>> filmleriGoster(int wrap_id) async {
    var url = "https://focaburada.com/api/tum_isletmeler_by_id.php";
    var veri = {"wrap_id":wrap_id.toString()};
    var cevap = await http.post(Uri.parse(url),body: veri);
    return parseCompaniesReturn(cevap.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueAccent,
        title: aramaYapiliyorMu ?
        TextField(
          decoration: InputDecoration(hintText: "Arama için birşey yazın"),
          onChanged: (aramaSonucu) {
            print("Arama sonucu : $aramaSonucu");
            setState(() {
              aramaKelimesi = aramaSonucu;
            });
          },
        )
            : Image.asset(
          'images/logooval.png', fit: BoxFit.contain, height: 55,),
        actions: [
          aramaYapiliyorMu ?
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
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

        actionsIconTheme: const IconThemeData(size: 32,),
      ),
      body: getBody(),
    );
  }
  Widget getBody() {
    return ListView(
      children: [
        const  SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const   SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Kategori : ${widget.category.wrap_name}",
                style: GoogleFonts.montserrat (textStyle: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: black)),),
            ),
            const   SizedBox(
              height: 5,
            ),
            Divider(height: 2),

            SingleChildScrollView(
              scrollDirection: Axis.vertical,

              child: FutureBuilder<List<Companies>>(
                future:  aramaYapiliyorMu ? aramaYap(aramaKelimesi): filmleriGoster(int.parse(widget.category.wrap_id)),

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
                                          image: CachedNetworkImageProvider(
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
                                    const   SizedBox(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Wrap(
                                        direction: Axis.horizontal, //Vertical || Horizontal

                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: Text( companies.adres,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,  color: Colors.grey,),),
                                          ),

                                        ],
                                      ),

                                    ),
                                    const   SizedBox(
                                      height: 10,
                                    ),

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

            ),

          ],
        ),

      ],
    );

  }


}
