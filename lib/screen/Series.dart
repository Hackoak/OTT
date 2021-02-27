import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Series {
  final int total;
  final int entries;
  final String title;
  final String programType;
  final String images;
  final String posterArt;
  final String url;
  final String width;
  final String height;
  final int releaseYear;

  Series(
      {this.total,
      this.entries,
      this.title,
      this.programType,
      this.images,
      this.posterArt,
      this.url,
      this.width,
      this.height,
      this.releaseYear});

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      title: json['entries'][0]["title"] as String,
      programType: json['entries'][0]['programType'] as String,
      entries: json['entries'] as int,
      url: json['entries'][0]['images']['Poster Art']['url'] as String,
      posterArt: json['postArt'] as String,
      images: json['images'] as String,
      releaseYear: json['entries'][0]['releaseYear'] as int,
      total: json['total'] as int,
    );
  }
}

class SeriesS extends StatefulWidget {
  @override
  _SeriesSState createState() => _SeriesSState();
}

class _SeriesSState extends State<SeriesS> {
  Future<Series> fetchData() async {
    var url =
        'https://raw.githubusercontent.com/StreamCo/react-coding-challenge/master/feed/sample.json';

    final responce = await http.get(url);

    if (responce.statusCode == 200) {
      // print(':::::::::::::Successs');
      return Series.fromJson(json.decode(responce.body));
    } else {
      throw Exception('Failed to load Series');
    }
  }

  Future<Series> futureseries;
  @override
  void initState() {
    // futureseries = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Series",
          style: TextStyle(fontSize: 32),
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 70,
      ),
      body: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString("assets/Rest.json"),
          builder: (context, snapshot) {
            var mydata = json.decode(snapshot.data.toString());
            if (mydata != null) {
              // if(mydata[]){
              return Container(child: _seriesGridView(mydata));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  GridView _seriesGridView(mydata) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: mydata['total'],
      padding: EdgeInsets.all(10.0),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        if (mydata['entries'][index]['programType'] == 'series') {
          return myGrid(
            // mydata['entries'][index].releaseYear.toString(),
            mydata['entries'][index]['title'].toString(),
            mydata['entries'][index]['images']['Poster Art']['url'].toString(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget myGrid(
    String gridName,
    String gridImage,
  ) {
    return Scaffold(
      body: Container(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            // color: Colors.black,
            // border: Border.all(color: Colors.white, width: 2.0),
            // borderRadius: BorderRadius.circular(24),
            // shape: BoxShape.rectangle,
            // image: DecorationImage(image: AssetImage('lunch.icon'))
          ),
          child: Stack(children: <Widget>[
            Opacity(
              opacity: 1.0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: new NetworkImage(gridImage),
                    )),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                      )),
                    ],
                  )),
                  // Text()
                  Padding(
                    padding: const EdgeInsets.only(top: 83.0),
                    child: Text(
                      gridName,
                      style: TextStyle(color: Colors.white, fontSize: 9),
                    ),
                  )
                ])
          ]),
        ),
      ),
    );
  }
}
