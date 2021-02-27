import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Movies {
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

  Movies(
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

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
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

class MovieS extends StatefulWidget {
  @override
  _MovieSState createState() => _MovieSState();
}

class _MovieSState extends State<MovieS> {
  Future<Movies> fetchData() async {
    var url =
        'https://raw.githubusercontent.com/StreamCo/react-coding-challenge/master/feed/sample.json';

    final responce = await http.get(url);

    if (responce.statusCode == 200) {
      // print(':::::::::::::Successs');
      return Movies.fromJson(json.decode(responce.body));
    } else {
      throw Exception('Failed to load Movies');
    }
  }

  Future<Movies> futureMovies;
  @override
  void initState() {
    // futureMovies = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movies",
          style: TextStyle(fontSize: 32),
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 50,
      ),
      body: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString("assets/flu.json"),
          builder: (context, snapshot) {
            var mydata = json.decode(snapshot.data.toString());
            if (mydata != null) {
              // if(mydata[]){
              return Container(child: _moviesGridView(mydata));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  GridView _moviesGridView(mydata) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: mydata['total'],
      padding: EdgeInsets.all(0.0),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        if (mydata['entries'][index]['programType'] == 'movie') {
          return myGrid(
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
            borderRadius: BorderRadius.circular(30),
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
                        padding: const EdgeInsets.all(0.0),
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
