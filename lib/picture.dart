import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pic_match/first.dart';
import 'package:pic_match/second.dart';
import 'package:timer_count_down/timer_count_down.dart';

void main() {
  runApp(MaterialApp(
    home: pic(),
  ));
}

class pic extends StatefulWidget {
  int? lno;
    pic([this.lno]);
  @override
  State<pic> createState() => _picState();
}

class _picState extends State<pic> {
  List pic = [];
  List pic1 = [];
  int a = 5;
  int x = 1;
  int a1 = 1;
  int stop1 = 0;
  bool t = false;
  List<bool> temp = [];
  int pos1 = 0, pos2 = 0;
  int level_no = 0;
  int cnt=0;


  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('myassets/'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      pic = imagePaths;
      pic.shuffle();
      for (int i = 0; i < 6; i++) {
        pic1.add(pic[i]);
        pic1.add(pic[i]);
      }
      pic1.shuffle();
      print(pic);
    });
  }

  @override
  void initState() {
    if(widget.lno==null){
      level_no = first.prefs!.getInt("levelno") ?? 0;
    }else
    {
      level_no=widget.lno!;
    }
    // level_no=widget.lno!;
    print(level_no);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
                width: double.infinity,
                height: 50,
                color: Colors.teal,
                alignment: Alignment.center,
                child: Text("TIME : NO TIME LIMIT")),
            content: Text("YOU HAVE 5 seconds to remind Image"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    t = true;
                    temp = List.filled(12, true);
                    _initImages();
                    get();
                    setState(() {});
                  },
                  child: Text("OK")),
            ],
          );
        },
      );
    });
  }

  get() async {
    for (int i = 5; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      a = i;
      if (i == 0) {
        temp = List.filled(12, false);
        // a++;
        // print(a);
      }
      setState(() {});
    }
    for (int i = 0; i < 100; i++) {
      await Future.delayed(Duration(seconds: 1));
      a1 = i;
      stop1 = a1;
      if (temp[0] &&
          temp[1] &&
          temp[2] &&
          temp[3] &&
          temp[4] &&
          temp[5] &&
          temp[6] &&
          temp[7] &&
          temp[8] &&
          temp[9] &&
          temp[10] &&
          temp[11]) {
        // stop1=a1;
        break;
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: (a == 0) ? Text("${a1}") : Text("${a}"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(color: Colors.teal.shade50,
              child: (t)
                  ? Countdown(
                      seconds: 5,
                      build: (BuildContext context, double time) {
                        return SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                trackHeight: 5,
                                thumbColor: Colors.transparent,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 0.0)),
                            child: Slider(
                              value: time,
                              max: 5,
                              min: 0,
                              activeColor: Colors.teal,
                              inactiveColor: Colors.white,
                              onChanged: (double value) {},
                            ));
                      },
                interval: Duration(seconds: 1),
                onFinished: (){
                  temp = List.filled(12, false);
                  setState(() {});

                },
                    )
                  : Text(""),

            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              color: Colors.teal.shade50,
              child: Column(
                children: [
                  // Text(""),
                  Expanded(flex: 1, child: Text("")),
                  Expanded(
                    flex: 9,
                    child: GridView.builder(
                      itemCount: pic1.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (!temp[index] && x == 1) {
                              temp[index] = true;
                              x = 3;
                              pos1 = index;
                              Future.delayed(Duration(milliseconds: 200))
                                  .then((value) {
                                x = 2;
                                setState(() {});
                              });
                            }
                            if (!temp[index] && x == 2) {
                              temp[index] = true;
                              x = 3;

                              pos2 = index;

                              if (pic1[pos1] == pic1[pos2]) {
                                x = 1;
                                cnt++;
                                print("Image Match");
                                if (cnt==6)
                                  {
                                    int temp_sec=first.prefs!.getInt("level_time${level_no}") ?? 0;
                                    if(stop1<temp_sec)
                                    {
                                      first.prefs!.setInt("level_time${level_no}", stop1);
                                    }
                                    if(widget.lno==null){
                                      level_no++;
                                      first.prefs!.setInt("levelno", level_no);
                                      first.prefs!.setInt("level_time${level_no}", stop1);
                                    }
                                    showDialog(barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Container(
                                              width: double.infinity,
                                              height: 50,
                                              color: Colors.teal,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "NEW RECORD",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.teal.shade50),
                                              )),
                                          content: Text(
                                              "${stop1}Seconds \n CONGRATULATION....\n${level_no+1} Completed",
                                              style: TextStyle(fontSize: 20)),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return second();
                                                            },
                                                          ));
                                                    },
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      height: 50,
                                                      width: 100,
                                                      color: Colors.teal,
                                                      child: Text("OK",
                                                          style: TextStyle(
                                                              fontSize: 20)),
                                                    )),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  }
                              } else {
                                Future.delayed(Duration(milliseconds: 200))
                                    .then((value) {
                                  temp[pos1] = false;
                                  temp[pos2] = false;
                                  x = 1;
                                  setState(() {});
                                });
                              }
                            }
                            setState(() {});
                          },
                          child: Visibility(
                            visible: temp[index],
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(width: 2, color: Colors.teal),
                                  borderRadius: BorderRadius.circular(5)),
                              height: 100,
                              width: 100,
                              child: Image.asset("${pic1[index]}"),
                            ),
                            replacement: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.teal,
                                  ),
                                  color: Colors.white),
                              height: 100,
                              width: 100,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
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
