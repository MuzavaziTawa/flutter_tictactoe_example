import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      home: Scaffold(body: MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Created by Mufungo Geeks

  //NB: Make sure you don't use static numbers when defining font size
  //    height and width, so as to accomodate for diferent screen sizes.
  //    WATCH THIS TO SEE HOW - https://www.youtube.com/watch?v=SC0TZMl_YC8

  //NB: Its advisable to put widget in their own classes for readability
  //    and usability in different classes. However, for the purpose of
  //    demonstration, this works just fine.
  
  int player = 1;
  bool winnerfound = false;
  int winner = 0;

  List list = [];

  @override
  void initState() {
    super.initState();
    onResetList();
  }

  onResetList() {
    List newlist = [
      {"pos": 1, "checked": ""},
      {"pos": 2, "checked": ""},
      {"pos": 3, "checked": ""},
      {"pos": 4, "checked": ""},
      {"pos": 5, "checked": ""},
      {"pos": 6, "checked": ""},
      {"pos": 7, "checked": ""},
      {"pos": 8, "checked": ""},
      {"pos": 9, "checked": ""},
    ];
    setState(() {
      list = newlist;
      winner = 0;
      player = 1;
      winnerfound = false;
    });
  }

  onBoxTapped(item, index) {
    String mark = player == 1 ? "X" : "O";
    if (item['checked'] == "") {
      setState(() {
        list[index]['checked'] = mark;
        player = player == 1 ? 2 : 1;
      });
      onValidateGrid();
    }
  }

  onValidateGrid() {
    if (list[0]['checked'] != "" &&
        list[0]['checked'] == list[1]['checked'] &&
        list[1]['checked'] == list[2]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[0]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[3]['checked'] != "" &&
        list[3]['checked'] == list[4]['checked'] &&
        list[4]['checked'] == list[5]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[3]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[6]['checked'] != "" &&
        list[6]['checked'] == list[7]['checked'] &&
        list[7]['checked'] == list[8]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[6]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[0]['checked'] != "" &&
        list[0]['checked'] == list[3]['checked'] &&
        list[3]['checked'] == list[6]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[0]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[1]['checked'] != "" &&
        list[1]['checked'] == list[4]['checked'] &&
        list[4]['checked'] == list[7]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[1]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[2]['checked'] != "" &&
        list[2]['checked'] == list[5]['checked'] &&
        list[5]['checked'] == list[8]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[2]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[0]['checked'] != "" &&
        list[0]['checked'] == list[4]['checked'] &&
        list[4]['checked'] == list[8]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[0]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[2]['checked'] != "" &&
        list[2]['checked'] == list[4]['checked'] &&
        list[4]['checked'] == list[6]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[2]['checked'] == "X" ? 1 : 2;
      });
    }
  }

  Widget gridView() {
    return Expanded(
      flex: 0,
      child: Container(
        margin: const EdgeInsets.only(top: 150),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: List.generate(list.length, (index) {
            var item = list[index];
            return boxView(item, index);
          }),
        ),
      ),
    );
  }

  Widget boxView(item, index) {
    return InkWell(
      onTap: () {
        onBoxTapped(item, index);
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
          child: Text(
            item['checked'],
            style: const TextStyle(fontSize: 50),
          )),
    );
  }

  Widget resetButton() {
    return InkWell(
      onTap: () {
        onResetList();
      },
      child: Container(
        width: 150,
        height: 40,
        margin: const EdgeInsets.only(top: 20),
        color: Colors.green[700],
        alignment: Alignment.center,
        child: const Text(
          "Reset Scores",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        gridView(),
        winner == 0
            ? Container(height: 0)
            : Text(
                "Player $winner wins",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontStyle: FontStyle.italic),
              ),
        resetButton()
      ],
    ));
  }
}
