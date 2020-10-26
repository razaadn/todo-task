import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/ui/home_page.dart';
import 'package:task/ui/home_page2.dart';

class Sliderpage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green, // Your app THEME-COLOR
      ),
      home: MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  CarouselSlider carouselSlider;
  int _current = 0;

  String appName, packageName, version, buildNumber;
  final _textEditingController = TextEditingController();
  final _textEditingController1 = TextEditingController();

  String VersionCode,
      FirebaseID,
      IsDelete,
      IsLogin,
      IsBusy,
      Androidurl,
      IOSUrl,
      checkIsLogin;
  List data1, data3;
  List imgList;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  double iheight;
  Future future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    imgList = new List();
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    // here set and put condition for property id
    /* var response = json.decode(payload) as Map;

    String receivedid = response['receiverid'];

    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new Messages(receivedid,"4AOFjyTCBGY1rY8TPDoWOpryBPH2")),
    );*/
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    imgList = [
      'images/5.0x/02.jpg',
      'images/5.0x/03.jpg',
      'images/5.0x/04.jpg',
      'images/5.0x/02.jpg',
      'images/5.0x/03.jpg',
      'images/5.0x/04.jpg',
    ];

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double yourWidth = width * 0.65;
    double yourheight = height * 0.9;

    return Scaffold(
      //drawerScrimColor: Colors.transparent,

      body: WillPopScope(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: new GestureDetector(
              child: Container(
                color: Colors.white,
                child: Container(
                  child: ClipRRect(
                    child: Stack(
                      children: [
                        carouselSlider = CarouselSlider(
                          height: yourheight,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          reverse: false,
                          enableInfiniteScroll: true,
                          autoPlayInterval: Duration(seconds: 10),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 3000),
                          pauseAutoPlayOnTouch: Duration(seconds: 10),
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index) {
                            setState(() {
                              _current = index;
                            });
                          },
                          items: imgList.map((imgUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                if (_current == 0) {
                                  return Center(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        child: Text(
                                          "Welcome to Clear\n Tap or swipe to begin",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  );
                                } else if (_current == 1) {
                                  return Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              child: Text(
                                                "Clear sorts items by Priority",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              child: Text(
                                                "important items are highlighted\nat the top",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: FractionalOffset.center,
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              child: Image(
                                                image: AssetImage(imgUrl),
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (_current == 2) {
                                  return Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              child: Text(
                                                "Tap and hold to pick an item up",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              child: Text(
                                                "Drag it up and down to change its priority",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: FractionalOffset.center,
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              child: Image(
                                                image: AssetImage(imgUrl),
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (_current == 3) {
                                  return Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 7,
                                        child: Center(
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              child: Text(
                                                "There are three navigation levels...",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Align(
                                          alignment: FractionalOffset.center,
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              child: Image(
                                                image: AssetImage(imgUrl),
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (_current == 4) {
                                  return Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 7,
                                        child: Center(
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              child: Text(
                                                "Pinch together vertically to\ncollapse your current level and\nnavigate up",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Align(
                                          alignment: FractionalOffset.center,
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              child: Image(
                                                image: AssetImage(imgUrl),
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (_current == 5) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "Sign up to the newsletter, and\nunlock a theme for your lists.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.mail_outline,
                                          size: 120,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: new TextField(
                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              filled: true,
                                              hintStyle: new TextStyle(
                                                  color: Colors.grey[800]),
                                              hintText: "Email Address",
                                              fillColor: Colors.white70),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              width: 150,
                                              height:70,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 20,
                                                    top: 10,
                                                    bottom: 10),
                                                child: new  RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      side: BorderSide(color: Colors.black)),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(builder: (_) => HomePage(title: 'My Todo List')),
                                                    );
                                                  },
                                                  textColor: Colors.black,
                                                  child: Text("Step 2".toUpperCase(),
                                                      style: TextStyle(fontSize: 14)),
                                                ),
                                              ),
                                            ),
                                            onTap: () {

                                            },),
                                          Spacer(),
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              width: 150,
                                              height:70,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 20,
                                                    top: 10,
                                                    bottom: 10),
                                                child: new  RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      side: BorderSide(color: Colors.black)),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(builder: (_) => HomePage2(title: 'My Todo List')),
                                                    );
                                                  },
                                                  textColor: Colors.black,
                                                  child: Text("Step 3".toUpperCase(),
                                                      style: TextStyle(fontSize: 14)),
                                                ),
                                              ),
                                            ),
                                            onTap: () {

                                            }, ),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              },
                            );
                          }).toList(),
                        ),
                        _current == 0
                            ? Container(
                                color: Colors.white,
                                child: SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                              )
                            : Align(
                                //alignment: FractionalOffset.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: map<Widget>(imgList, (index, url) {
                                    return Align(
                                      alignment: _current == 0 || _current == 5
                                          ? FractionalOffset.bottomCenter
                                          : FractionalOffset.center,
                                      child: Container(
                                        width: 10.0,
                                        height: 10.0,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 2.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _current == index
                                              ? Colors.green[800]
                                              : Colors.grey[300],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              onTap: () {
                /*if(){
                            _launchURL();
                          }*/
              },
            ),
          ),
        ),
        onWillPop: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          //MoveToBackground.moveTaskToBack();
          //Navigator.pop(context);
          // Navigator.pop(context,true);
          /*  Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));*/
          // Navigator.pop(context,true);
        },
      ),
      // drawerScrimColor: Colors.transparent,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class DrawerStateInfo with ChangeNotifier {
  int _currentDrawer = 0;

  int get getCurrentDrawer => _currentDrawer;

  void setCurrentDrawer(int drawer) {
    _currentDrawer = drawer;
    notifyListeners();
  }

  void increment() {
    notifyListeners();
  }
}
