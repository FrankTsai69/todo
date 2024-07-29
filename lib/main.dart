import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(home: Appbar()));
}

class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(//123456
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
  String n = "";

  final adddo = GlobalKey<FormState>();
  List item = [
    {"title": "預設1", "checked": false},
    {"title": "預設2", "checked": false},
    {"title": "預設3", "checked": false}
  ];
  List done = [
    {"title": "預設4", "checked": true},
    {"title": "預設5", "checked": true},
    {"title": "預設6", "checked": true}
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
            var ans = await _showAlertDialog(context, 0,);
            print(ans);
            if (ans != "") {
              setState(() {
                item.add({"title": ans, "checked": false});
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
                              done.add({
                                "title": item[index]["title"],
                                "checked": !item[index]["checked"]
                              });
                              item.remove(item[index]);
                            });
                          },
                        ),
                      ),
                      Container(
                          width: list_width - 210,
                          child: TextButton(
                              onPressed: () {
                                
                                  var ans = _showAlertDialog(context, 2,);
                                
                              },
                              child: Text(
                                "${item[index]["title"]}",
                                textAlign: TextAlign.left,
                              ))),
                      Container(
                          child: Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                var ans =
                                    await _showAlertDialog(context, 1,);
                                setState(() {
                                  if (ans != "") {
                                    item[index]["title"] = ans;
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
                              item.add({
                                "title": done[index]["title"],
                                "checked": !done[index]["checked"]
                              });
                              done.remove(done[index]);
                            });
                          },
                        )),
                    Container(
                      width: list_width - 210,
                      child: Text("${done[index]["title"]}",
                          textAlign: TextAlign.left),
                    ),
                    Container(
                        child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              var ans = await _showAlertDialog(context, 1,);
                              setState(() {
                                if (ans != "") {
                                  done[index]["title"] = ans;
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
                            item.add({"title": val, "checked": false});
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

Future<String?> _showAlertDialog(
    BuildContext context, int mode, [Map? item]) async {
  //mode:模式，0:新增，1:修改，2:顯示項目
  String a = "";
  if (mode == 0) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('新增事項'),
              content: Container(
                height: 70,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(labelText: 'title'),
                      onChanged: (val) {
                        a = val;
                      },
                    )
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
                    Navigator.of(context).pop(a);
                  },
                ),
                TextButton(
                  child: Text('取消',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  onPressed: () {
                    Navigator.of(context).pop("");
                  },
                )
              ]);
        });
  } else if (mode == 1) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('修改事項'),
              content: Container(
                height: 70,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(labelText: 'title'),
                      onChanged: (val) {
                        a = val;
                      },
                    )
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
                    Navigator.of(context).pop(a);
                  },
                ),
                TextButton(
                  child: Text('取消',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  onPressed: () {
                    Navigator.of(context).pop("");
                  },
                )
              ]);
        });
  } else if (mode == 2) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("a"),
              content: Container(
                height: 70,
                child: Column(
                  children: <Widget>[Text("名稱"), Text("說明")],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('修改',
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                  onPressed: () {
                    //adddo.currentState!.save();
                    Navigator.of(context).pop(a);
                  },
                ),
                TextButton(
                  child: Text('取消',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  onPressed: () {
                    Navigator.of(context).pop("");
                  },
                )
              ]);
        });
  }
}
