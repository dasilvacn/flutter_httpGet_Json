import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:odev2/json.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Odev2",
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<Veri> _veriler = List<Veri>();

  Future<List<Veri>> fetchVeri() async {
    var url = "https://kitapbulal.com/api/test/getProducts";
    var response = await http.get(url);
    var veriler = List<Veri>();
    if (response.statusCode == 200) {
      var verilerJson = json.decode(response.body);
      for (var veriJson in verilerJson) {
        veriler.add(Veri.fromJson(veriJson));
      }
    }
    return veriler;
  }

  @override
  void initState() {
    fetchVeri().then((value) {
      setState(() {
        _veriler.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          "E Ticaret",
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          Icon(
            Icons.exit_to_app,
            size: 30,
          ),
          SizedBox(width: 20),
        ],
      ),
      drawer: Drawer(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            color: Colors.teal[50],
            elevation: 10,
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //resim
                SizedBox(height: 20),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        _veriler[index].foto,
                      ),
                    ),
                  ),
                ),
                //isim
                SizedBox(height: 20),
                Text(
                  _veriler[index].name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontFamily: "Audiowide"),
                ),
                SizedBox(height: 20),
                //fiyat
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _veriler[index].price.toString(),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "₺",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: Colors.grey),
                    ),
                    child: Text(
                      "Satın Al",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: "Audiowide",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: _veriler.length,
      ),
    );
  }
}
