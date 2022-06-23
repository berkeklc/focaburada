import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focaburada/main.dart';
import 'package:focaburada/theme/colors.dart';

import '../home_page.dart';
import 'CatPage.dart';
import 'home.dart';
import 'ilanlar.dart';

class ProfPage extends StatefulWidget {
  @override
  _ProfPageState createState() => _ProfPageState();
}

class _ProfPageState extends State<ProfPage> with TickerProviderStateMixin {
  List itemsTemp = [];
  int itemLength = 0;
  int pageIndex = 2;
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blueAccent, Colors.lightBlueAccent])),
          child: SizedBox(

            width: double.infinity,
            height: 190.0,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://focaburada.com/doc/users/img1/0.jpg",
                    ),
                    radius: 50.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${successmail ?? "Ziyaretçi"}',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),

    Container(
    child: Padding(
    padding:
    const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Text(
    "Üye Bilgileri",
    style: TextStyle(
    color: Colors.blueAccent,
    fontStyle: FontStyle.normal,
    fontSize: 22.0),
    ),
    SizedBox(
    height: 10.0,
    ),

        Text(
    '${successmail ?? "Ziyaretçi"} \n\n',
    style: TextStyle(
    fontSize: 22.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    color: Colors.black,
    letterSpacing: 0,
    ),
    ),
    ],
    ),
    ),
    ),
    const SizedBox(
    height: 20.0,
    ),
        ],




      ),
    ),
    );
  }
}
