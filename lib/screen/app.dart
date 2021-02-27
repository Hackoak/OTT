import 'package:OTT/screen/Series.dart';
import 'package:OTT/screen/movies.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget bottomBar() {
    return Scaffold(
      body: Container(
        child: Center(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 58.0),
                child: Text(
                  'Home  |  ',
                  style: TextStyle(color: Colors.white38, fontSize: 10),
                ),
              ),
              Text(
                'Terms And Conditions  |  ',
                style: TextStyle(color: Colors.white38, fontSize: 10),
              ),
              Text(
                'privacy Policy  |  ',
                style: TextStyle(color: Colors.white38, fontSize: 10),
              ),
              Text(
                'Collection Statement    ',
                style: TextStyle(color: Colors.white38, fontSize: 10),
              ),
            ],
          ),
        ),
        height: 180,
        decoration: BoxDecoration(
          color: Colors.black,

          //  height:
          //  border
        ),
      ),
    );
  }

  Widget _series() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SeriesS();
        }));
      },
      child: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 120.0),
            child: Text(
              'SERIES',
              style: TextStyle(color: Colors.white38, fontSize: 23),
            ),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        height: 180.0,
        width: 130.0,
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            image: DecorationImage(image: AssetImage('flim.png'))),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Streaming",
          style: TextStyle(fontSize: 32),
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 100,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 30.0),
              child: Column(
                children: <Widget>[
                  _series(),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MovieS();
                }));
              },
              child: Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 120.0),
                      child: Text(
                        'MOVIES',
                        style: TextStyle(color: Colors.white38, fontSize: 23),
                      ),
                    ),
                  ),
                ),
                margin: const EdgeInsets.only(top: 20, left: 190.0, right: 30),
                height: 180.0,
                width: 130.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(image: AssetImage('flim.png'))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 500.0,
              ),
              child: Container(
                child: Container(
                  child: bottomBar(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
