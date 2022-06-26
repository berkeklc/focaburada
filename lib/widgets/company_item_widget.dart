import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:focaburada/model/model.dart';
import 'package:focaburada/pages/DetaySayfa.dart';

class CompanyItemWidget extends StatelessWidget {
  final Companies company;

  const CompanyItemWidget({
    Key key,
    @required this.company,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetaySayfa(
              company: company,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
            left: 15, right: 15, top: 10, bottom: kFloatingActionButtonMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    "https://focaburada.com/doc/company/${company.file1 == null ? "0.png" : company.file1}",
                  ),
                  fit: BoxFit.fill,
                ),
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
                        child: Text(
                          company.isletme_adi,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    company.semt_adi,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  color: Colors.blue,
                  padding: const EdgeInsets.only(
                    top: 3,
                    left: 10,
                    right: 10,
                    bottom: 3,
                  ),
                  child: Text(
                    company.kategori_adi,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
