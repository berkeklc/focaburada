import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:focaburada/modules/home/home_page.dart';
import 'package:focaburada/widgets/text.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class Register extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Register Screen',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: OnBoard(),
    );
  }
}

class OnBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset("images/logo.png"),
              const SizedBox(
                height: 30,
              ),
              Helper.text("Foça'ya Hoşgeldin", 22, 0, Colors.blueAccent,
                  FontWeight.w700),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Helper.text(
                    "Foça Burada uygulamasında işletmeni kaydedip insanlara ulaşabilirsin ya da bölgedeki işletmeleri kolayca bulabilir ve iş ilanlarını görüntüleyebilirsin.",
                    18,
                    1,
                    Colors.black,
                    FontWeight.w500),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Signup()));
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "Devam Et",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.shade200,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const Spacer(),
            ],
          )),
    );
  }
}

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

class _SignupState extends State<Signup> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 25, right: 25),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 65.0),
                child: Container(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 22,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: CachedNetworkImage(
                                imageUrl: "https://cdn-icons-png.flaticon.com/128/1617/1617543.png",
                                height: 33,
                              ),
                            )
                          ],
                        ),
                        Helper.text("Hesap Oluştur", 20, 0.8, Colors.black,
                            FontWeight.w600),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 55),
                          child: Container(
                            height: 54,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, left: 20),
                              child: TextFormField(
                                controller: _email,
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  hintText: "E-Posta",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20, right: 20),
                          child: Container(
                            height: 54,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, left: 20),
                              child: TextFormField(
                                controller: _password,
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  hintText: "Şifre",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            child: Center(
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () {
                                    RegistirationUser();
                                  },
                                  splashColor:
                                      const Color.fromRGBO(128, 237, 153, 1),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 100),
                                    child: Text(
                                      "Kayıt Ol",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  )),
                            ),
                            height: 54,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amber.shade200),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Hesabın var mı? "),
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Giriş yap",
                                style: TextStyle(
                                    color: Color.fromRGBO(23, 87, 122, 1)),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20.0, left: 20, right: 20),
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
                                    child: Helper.text(
                                        "Ziyaretçi olarak devam et",
                                        15,
                                        0.5,
                                        Colors.black,
                                        FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            height: 54,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                ),
              )
            ],
          ),
        ));
  }

  Future RegistirationUser() async {
    var APIURL = "https://focaburada.com/api/kayit.php";
    Map mapeddate = {'e_mail': _email.text, 'pass': _password.text};

    print("Json Data: ${mapeddate}");

    http.Response response =
        await http.post(Uri.parse(APIURL), body: mapeddate);

    var data = jsonDecode(response.body);

    successmail = emailController.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );

    print("Data ${data}");
  }
}
