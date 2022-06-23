import 'package:flutter_svg/svg.dart';
import 'package:focaburada/data/Cvs.dart';
import 'package:flutter/material.dart';

class DetaySayfailan extends StatefulWidget {
  Cvs ilan;

  DetaySayfailan({this.ilan});

  @override
  _DetaySayfailanState createState() => _DetaySayfailanState();
}

class _DetaySayfailanState extends State<DetaySayfailan> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.ilan.isletme_adi),
      ),

      body: SingleChildScrollView(

        child: Column(

          children: <Widget>[
            const   SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(widget.ilan.isletme_adi.toString(),style: TextStyle(fontSize: 30),),

                ),
              ),

            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top:10,bottom:0,),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: const Text('İş detayı ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(widget.ilan.hakkimizda.toString(),style: TextStyle(fontSize: 20),),

                ),
              ),

            ),
            const   SizedBox(
              height: 15,
            ),
            Row(
              children: [

                const Padding(
                  padding: EdgeInsets.only(left: 15, top:0,right: 5,bottom:5),

                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.blueAccent,
                    child: IconButton(
                      icon: Icon(
                        Icons.phone,
                        size: 18.0,
                        color: Colors.white,
                      ),

                    ),
                  ),

                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top:0, right: 5),
                      child: Align(

                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: const Text('Telefon numarası',style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),),

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top:2,right: 5,bottom:5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(widget.ilan.telefon.toString(),style: TextStyle(fontSize: 16),),

                        ),
                      ),

                    ),
                  ],
                )

              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15, top:10,right: 5,bottom:5),

                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.blueAccent,
                    child: IconButton(
                      icon: Icon(
                        Icons.location_on,
                        size: 18.0,
                        color: Colors.white,
                      ),

                    ),
                  ),

                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(

                      padding: const EdgeInsets.only(left: 7, top:10, right: 5),
                      child: Align(

                        child: Container(
                          child: const Text('Adres ',style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),),

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 300,
                          child: Text(widget.ilan.adres.toString(),style: const TextStyle(fontSize: 14, ),  ),
                        ),
                      ),
                    ),
                  ],
                )

              ],

            ),



          ],
        ),
      ),

    );
  }


}
