import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:focaburada/main.dart';
import 'package:focaburada/modules/home/home_page.dart';
import 'package:focaburada/pages/ilanlar.dart';
import 'package:focaburada/pages/profil.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
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
                  builder: (context) => HomePage(),
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
    );
  }
}
