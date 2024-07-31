import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sprintf/sprintf.dart';

void main() {
  runApp(MaterialApp(home: Appbar()));
}

class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(//1234567
        // home: Scaffold(
        //     appBar: AppBar(
        //         bottom:TabBar(tabs:[Tab(text:'abc')],controller:),
        //         title: Text("abc"),
        //         centerTitle: true,
        //         backgroundColor: (Color.fromARGB(25, 0, 0, 255)),
        //         leading:Builder(builder:(BuildContext context){
        //           return IconButton(icon: const Icon(Icons.menu),onPressed:(){Scaffold.of(context).openDrawer();},tooltip:"文字內容",);
        //         }),
        //         ),
        //     drawer:Drawer(child:Text("left"),),
        //     body: Text("acb"))
        );
  }
}

class Appbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppBarForTabBarDemo();
  }
}

class AppBarForTabBarDemo extends State with SingleTickerProviderStateMixin {
  //String n = "";

  final adddo = GlobalKey<FormState>();
  List item = [
    {
      "name": "預設1",
      "directions": "預設1",
      "checked": false,
      "date": "1999-06-09 14:31"
    },
    {
      "name": "預設2",
      "directions": "預設2",
      "checked": false,
      "date": "2000-06-09 14:31"
    },
    {
      "name": "預設3",
      "directions": "預設3",
      "checked": false,
      "date": "2001-06-09 14:31"
    }
  ];
  List done = [
    {
      "name": "預設4",
      "directions": "預設4",
      "checked": true,
      "date": "2002-06-09 14:31"
    },
    {
      "name": "預設5",
      "directions": "預設5",
      "checked": true,
      "date": "2003-06-09 14:31"
    },
    {
      "name": "預設6",
      "directions": "預設6",
      "checked": true,
      "date": "2003-06-09 14:31"
    }
  ];
  final List<Tab> _tab = <Tab>[
    Tab(text: '未完成'),
    Tab(text: '完成'),
    Tab(text: '新增')
  ];
  var _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _tab.length);
    super.initState();
    print("a");
  }

  Widget divider1 = Divider(thickness: 1);
  Widget divider2 = Divider(thickness: 1);

  @override
  Widget build(BuildContext context) {
    double list_width = MediaQuery.of(context).size.width;
    print("list_width:${list_width}");
    return Scaffold(
        floatingActionButton: IconButton(
          icon: Icon(Icons.add_circle),
          onPressed: () async {
            var ans = await _showAlertDialog(
              context,
              0,
            );
            print(ans);
            if (ans?.length == 3) {
              setState(() {
                item.add({
                  "name": ans?[0],
                  "directions": ans?[1],
                  "checked": false,
                  "date": ans?[2]
                });
              });
            }
          },
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            //第一頁
            Center(
              child: Container(
                width: list_width - 30,
                alignment: Alignment.center,
                child: ListView.separated(
                  itemCount: item.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return index % 2 == 0 ? divider1 : divider2;
                  },
                  itemBuilder: (context, index) {
                    return Row(children: [
                      Container(
                        width: 60,
                        child: Checkbox(
                          value: false,
                          onChanged: (e) {
                            setState(() {
                              done.add(item[index]);
                              item.remove(item[index]);
                            });
                          },
                        ),
                      ),
                      Container(
                          width: list_width - 210,
                          child: TextButton(
                              onPressed: () async {
                                var list = await _showAlertDialog(context, 2, {
                                  "name": item[index]["name"],
                                  "index": "${index + 1}",
                                  "directions": item[index]["directions"],
                                  "date": item[index]["date"]
                                });
                                if (list?.length == 2) {
                                  print("object");
                                  setState(() {
                                    item[index]["name"] = list?[0];
                                    item[index]["directions"] = list?[1];
                                  });
                                }
                              },
                              child: Text(
                                "${item[index]["name"]}",
                                textAlign: TextAlign.left,
                              ))),
                      Container(
                          child: Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                var ans = await _showAlertDialog(context, 1, {
                                  "name": item[index]["name"],
                                  "index": "${index + 1}",
                                  "directions": item[index]["directions"],
                                  "date": item[index]["date"]
                                });
                                setState(() {
                                  if (ans?.length == 2) {
                                    item[index]["name"] = ans?[0];
                                    item[index]["directions"] = ans?[1];
                                  }
                                });
                              },
                              icon: Icon(Icons.create)),
                          IconButton(
                              onPressed: () async {
                                setState(() {
                                  item.remove(item[index]);
                                });
                              },
                              icon: Icon(Icons.delete))
                        ],
                      )),
                    ]);
                  },
                ),
              ),
            ),

            //第二頁
            Center(
                child: Container(
              width: list_width - 30,
              alignment: Alignment.center,
              child: ListView.separated(
                itemCount: done.length,
                separatorBuilder: (BuildContext context, int index) {
                  return index % 2 == 0 ? divider1 : divider2;
                },
                itemBuilder: (context, index) {
                  return Row(children: [
                    Container(
                        width: 60,
                        child: IconButton(
                          icon: Icon(Icons.rotate_right),
                          onPressed: () {
                            setState(() {
                              item.add(done[index]);
                              done.remove(done[index]);
                            });
                          },
                        )),
                    Container(
                      width: list_width - 210,
                      child: TextButton(
                        onPressed: () async {
                          var list = await _showAlertDialog(context, 2, {
                            "name": done[index]["name"],
                            "index": "${index + 1}",
                            "directions": done[index]["directions"],
                            "date": done[index]["date"],
                          });
                          if (list?.length == 2) {
                            setState(() {
                              done[index]["name"] = list?[0];
                              done[index]["directions"] = list?[1];
                            });
                          }
                        },
                        child: Text("${done[index]["name"]}",
                            textAlign: TextAlign.left),
                      ),
                    ),
                    Container(
                        child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              var ans = await _showAlertDialog(context, 1, {
                                "name": done[index]["name"],
                                "index": "$index+1",
                                "directions": done[index]["directions"],
                                "date": done[index]["date"],
                              });
                              setState(() {
                                if (ans?.length == 2) {
                                  done[index]["name"] = ans?[0];
                                  done[index]["directions"] = ans?[1];
                                }
                              });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                done.remove(done[index]);
                              });
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ))
                  ]);
                },
              ),
            )),
            //第三頁
            Form(
                key: adddo,
                child: Column(children: [
                  SizedBox(
                      width: list_width * 3 / 4,
                      child: TextFormField(
                        cursorWidth: 10,
                        decoration: InputDecoration(labelText: 'title'),
                        onSaved: (val) {
                          setState(() {
                            item.add({"name": val, "checked": false});
                            adddo.currentState!.reset();
                          });
                        },
                      )),
                  SizedBox(
                    height: 30.0,
                  ),
                  Center(
                      child: Container(
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: Text('新增1',
                                style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0))),
                            onPressed: () {
                              adddo.currentState!.save();
                            },
                          )))
                ]))
          ],
        ),
        appBar: AppBar(
            leading: Icon(Icons.menu),
            automaticallyImplyLeading: true,
            title: Text("代辦清單"),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                tooltip: "search",
                onPressed: () {},
              )
            ],
            bottom: TabBar(tabs: _tab, controller: _tabController)));
  }
}

Future<List?> _showAlertDialog(BuildContext context, int mode,
    [Map? item]) async {
  //mode:模式，0:新增，1:修改，2:顯示項目
  String title = "";
  String directions = "";
  List list = [];
  if (mode == 0) {
    return showDialog<List>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('新增事項'),
              content: Container(
                height: 150,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(labelText: 'title'),
                      onChanged: (val) {
                        title = val;
                      },
                    ),
                    Container(height: 10),
                    Scrollbar(
                        child: TextFormField(
                            autofocus: false,
                            inputFormatters: [directionsformatter()],
                            minLines: 1,
                            maxLines: 5,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                labelText: 'directions',
                                border: OutlineInputBorder(),
                                hintText: "說明"),
                            onChanged: (val) {
                              directions = val;
                            }))
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('新增',
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                  onPressed: () {
                    //adddo.currentState!.save();
                    final date = DateTime.now();

                    String datetime =
                        "${date.year.toString()}-${sprintf("%02i", [
                          date.month.toInt()
                        ])}-${sprintf("%02i", [
                          date.day.toInt()
                        ])} ${sprintf("%02i", [
                          date.hour.toInt()
                        ])}:${sprintf("%02i", [date.minute.toInt()])}";
                    List list = [title, directions, datetime];
                    Navigator.of(context).pop(list);
                  },
                ),
                TextButton(
                  child: Text('取消',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  onPressed: () {
                    Navigator.of(context).pop(["0"]);
                  },
                )
              ]);
        });
  } else if (mode == 1) {
    return showDialog<List>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('修改事項'),
              content: Container(
                height: 300,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(labelText: 'title'),
                      initialValue: item?["name"],
                      onChanged: (val) {
                        item?["name"] = val;
                      },
                    ),
                    Container(
                      height: 10,
                    ),
                    Scrollbar(
                        child: TextFormField(
                            autofocus: false,
                            inputFormatters: [directionsformatter()],
                            minLines: 1,
                            maxLines: 5,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                labelText: "directions",
                                border: OutlineInputBorder()),
                            //maxLength: 21,
                            initialValue: item?["directions"],
                            onChanged: (String val) {
                              item?["directions"] = val;
                            })),
                    Text(item?["date"])
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('修改',
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                  onPressed: () {
                    //adddo.currentState!.save();
                    list = [item?["name"], item?["directions"]];
                    Navigator.of(context).pop(list);
                  },
                ),
                TextButton(
                  child: Text('取消',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  onPressed: () {
                    Navigator.of(context).pop(["0"]);
                  },
                )
              ]);
        });
  } else if (mode == 2) {
    return showDialog<List>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("第${item?["index"]}項"),
              content: Container(
                height: 250,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        autofocus: false,
                        readOnly: true,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: "名稱", border: InputBorder.none),
                        initialValue: item?["name"],
                        onChanged: (val) {
                          item?["name"] = val;
                        }),
                    Scrollbar(
                      child: TextFormField(
                          autofocus: false,
                          readOnly: true,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          decoration: InputDecoration(
                              labelText: "directions",
                              border: OutlineInputBorder()),
                          initialValue: item?["directions"],
                          onChanged: (val) {
                            item?["direction"] = val;
                          }),
                    ),
                    Text(item?["date"])
                  ],
                ),
              ),
              actions: <Widget>[
                /* TextButton(
                  child: Text('修改',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  onPressed: () {
                    
                    list=[item?["name"],item?["direction"]];
                    Navigator.of(context).pop(list);
                    }

                ),*/
                TextButton(
                  child: Text('關閉',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  onPressed: () {
                    Navigator.of(context).pop(["0"]);
                  },
                )
              ]);
        });
  }
}

class directionsformatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i > 0 && i % 10 == 0) {
        formattedText += '\n';
      }
      formattedText += newText[i];
    }
    return TextEditingValue(
        text: formattedText,
        selection: newValue.selection.copyWith(
            baseOffset: formattedText.length,
            extentOffset: formattedText.length));
  }
}
