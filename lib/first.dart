// import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pic_match/data.dart';
import 'package:pic_match/new.dart';
import 'package:pic_match/second.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: first(),
    debugShowCheckedModeBanner: false,
  ));
}

class first extends StatefulWidget {
  static SharedPreferences? prefs;

  // const first({super.key});


  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  // List<int> l=[0,1,2];
  bool temp1=false;
  bool temp2=false;
  bool temp3=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_prefs();

  }
  get_prefs()
  async {
    first.prefs = await SharedPreferences.getInstance();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SELECT MODE"), backgroundColor: Colors.teal),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Stack(children: [
              Container(
                color: Colors.teal.shade50,
                height: double.infinity,
                width: double.infinity,
                child: Column(children: [
                  Expanded(flex: 1, child: Text("")),
                  Expanded(
                    flex: 9,
                    child: GridView.builder(
                      itemCount: data.l.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationZ(data.l[index]),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 2))
                                ],
                                color: Colors.white,
                                image: DecorationImage(
                                    image: AssetImage("${data.img[index]}"),
                                    fit: BoxFit.fill)),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(flex: 1, child: Text("")),
                ]),
              ),
              Stack(children: [
                Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(75, 160, 75, 0),
                        // height: 250,
                        // width: 225,
                        child: Column(children: [
                          Expanded(
                              child: GestureDetector(
                                onTapDown: (details) {
                                  temp1=true;
                                  setState(() {});
                              },
                                onTapCancel: () {
                                  temp1=false;
                                  setState(() {

                                  });

                                },
                                onTapUp: (details) {
                                  temp1=false;

                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return Home();
                                  },));
                                  setState(() {

                                  });
                                },
                                child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(10),
                            color: (temp1)?Colors.teal.shade900:Colors.teal,
                            child: Text(
                                "NO TIME LIMIT",
                                style: TextStyle(
                                    color: Colors.teal.shade50, fontSize: 20),
                            ),
                          ),
                              )),
                          Expanded(
                              child: GestureDetector(
                                onTapDown: (details) {
                                  temp2=true;
                                  setState(() {});
                                },
                                onTapCancel: () {
                                  temp2=false;
                                  setState(() {

                                  });

                                },
                                onTapUp: (details) {
                                  temp2=false;

                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return second();
                                  },));
                                  setState(() {

                                  });
                                },
                                child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(10),
                            color: (temp2)?Colors.teal.shade900:Colors.teal,
                            child: Text(
                                "NORMAL",
                                style: TextStyle(
                                    color: Colors.teal.shade50, fontSize: 20),
                            ),
                          ),
                              )),
                          Expanded(
                              child: GestureDetector(onTapDown: (details) {
                                temp3=true;
                                setState(() {});
                              },
                                onTapCancel: () {
                                  temp3=false;
                                  setState(() {

                                  });

                                },
                                onTapUp: (details) {
                                  temp3=false;

                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return second();
                                  },));
                                  setState(() {

                                  });
                                },
                                child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(10),
                            color: (temp3)?Colors.teal.shade900:Colors.teal,
                            child: Text(
                                "HARD",
                                style: TextStyle(
                                    color: Colors.teal.shade50, fontSize: 20),
                            ),
                          ),
                              )),
                        ]),

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.teal, width: 5),
                            color: Colors.teal.shade50),
                      ),
                    ),
                    Text(""),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            color: Colors.teal,
                            child: Text(
                              "REMOVE ADS",
                              style: TextStyle(
                                  color: Colors.teal.shade50, fontSize: 15),
                            )),
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 70,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.teal, width: 5),
                            color: Colors.teal.shade50),
                      ),
                    ),
                    // Expanded(child: Text("")),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.teal, width: 5)),
                        child: Row(children: [
                          Expanded(
                              child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(10),
                            color: Colors.teal,
                            child: Text("SHARE",
                                style: TextStyle(
                                    color: Colors.teal.shade50, fontSize: 20)),
                          )),
                          Expanded(
                              child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(10),
                            color: Colors.teal,
                            child: Text("MORE GAMES",
                                style: TextStyle(
                                    color: Colors.teal.shade50, fontSize: 20)),
                          ))
                        ]),
                      ),
                    ),
                  ],
                ),
              ])
            ]),
          ),
          Expanded(
              flex: 1,
              child: Container(
                // width: double.infinity,
                color: Colors.teal,
              ))
        ],
      ),
    );
  }
}
