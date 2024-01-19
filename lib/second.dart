import 'package:flutter/material.dart';
import 'package:pic_match/data.dart';
import 'package:pic_match/first.dart';
import 'package:pic_match/new.dart';

// import 'package:pic_match/pic.dart';
import 'package:pic_match/picture.dart';
import 'package:shared_preferences/shared_preferences.dart';

class second extends StatefulWidget {
  const second({super.key});

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  List<bool> temp = List.filled(10, false);
  int level_no=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  get_prefs()
  async {
    first.prefs = await SharedPreferences.getInstance();

    level_no=first.prefs!.getInt("levelno")?? 0;
    print(level_no);
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
              Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 6,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, myindex) {
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 6,
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "MATCH ${myindex + 1}",
                                              style: TextStyle(
                                                  color: Colors.teal,
                                                  fontSize: 20),
                                            ))),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.teal,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Icon(
                                                color: Colors.teal,
                                                Icons.question_mark_sharp)))
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.teal,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    int l_no = (myindex * 10) + index + 1;
                                    int l_no1 = (myindex * 10) + index;


                                    return (l_no1<=level_no)?InkWell(onTap: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) {
                                        if(l_no1<level_no)
                                        {
                                          return pic(l_no1);
                                        }
                                        else
                                        {
                                          return pic();
                                        }
                                      },));
                                    },
                                      child: Container(height: 40,
                                        margin:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        alignment: Alignment.center,
                                        color:
                                             Colors.teal.shade100,
                                        child:  Wrap(children: [
                                          Text(
                                            "Level-${l_no} ${first.prefs!.getInt("level_time${l_no1}") ?? 0}",
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          (l_no1<level_no) ? Text(
                                            "s",
                                            style: TextStyle(fontSize: 25),
                                          ) : Text("")
                                        ],),
                                      ),
                                    ):Container(height: 40,
                                      margin:
                                      EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      alignment: Alignment.center,
                                      color:
                                      Colors.blue,
                                      child: Text(
                                        "LEVEL ${l_no}",
                                        style: TextStyle(
                                            color: Colors.teal.shade300),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          margin: EdgeInsets.all(50),
                          height: double.infinity,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              border: Border.all(
                                color: Colors.teal,
                                width: 5,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        );
                      },
                    ),
                  )
                ],
              )
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
