import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:focaburada/register.dart';
import 'package:http/http.dart' as http;
import 'modules/home/home_page.dart';

String successmail;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foça Burada',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color.fromRGBO(42, 22, 111, 1.0),
        child: Column(
          children: [
            SizedBox(
              height: 65,
            ),
            Container(
              width: 93,
              height: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      "https://focaburada.com/doc/focalogo.jpg",
                    ),
                    fit: BoxFit.fill,
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                padding: const EdgeInsets.only(
                    left: 40, top: 30, bottom: 20, right: 40),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    TextFormField(
                      controller: emailController,
                      style: const TextStyle(
                          fontSize: 20, color: Color.fromRGBO(23, 87, 122, 1)),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        labelText: 'E-posta',
                        prefixIcon: Icon(Icons.account_circle_rounded),
                        // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,),),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      style: const TextStyle(
                          fontSize: 20, color: Color.fromRGBO(23, 87, 122, 1)),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        labelText: 'Şifre',
                        prefixIcon: Icon(Icons.lock_rounded),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Şifremi Unuttum",
                            style: TextStyle(
                                color: Color.fromRGBO(23, 87, 122, 1)),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromRGBO(0, 146, 64, 1),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            login();
                          },
                          splashColor: const Color.fromRGBO(1, 132, 64, 1),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 60),
                            child: Text(
                              "Giriş yap",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Hesabın yok mu? "),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          },
                          child: const Text(
                            "Kayıt Ol",
                            style: TextStyle(
                                color: Color.fromRGBO(23, 87, 122, 1)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Ya da "),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20.0, left: 40, right: 40),
                      child: Container(
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                },
                                child: Text("Ziyaretçi olarak devam et",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
                        height: 44,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(
        Uri.parse("https://focaburada.com/api/tum_uyeler.php"),
        body: ({'e_mail': emailController.text, 'pass': passController.text}),
      );
      if (response.statusCode == 200) {
        var jsonData = null;
        jsonData = json.decode(response.body);
        for (var i = 0; i < jsonData['users'].length; i++) {
          if (jsonData['users'][i]['e_mail'] == emailController.text &&
              jsonData['users'][i]['pass'] == passController.text) {
            successmail = emailController.text;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Geçersiz Kullanıcı adı ya da şifre.")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Lütfen alanları doldurunuz.")));
    }
    setState(() {});
  }

  Future RegistirationUser() async {
    var APIURL = "https://focaburada.com/api/tum_uyeler.php";
  }
}
