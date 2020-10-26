import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:task/bloc/todo_bloc.dart';
import 'package:task/model/todo.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({Key key, this.title}) : super(key: key);
  final String title;

  //We load our Todo BLoC that is used to get
  //the stream of Todo for StreamBuilder

  _MessagesState createState() => _MessagesState(title);
}

class _MessagesState extends State<HomePage2> {
  final TodoBloc todoBloc = TodoBloc();
  final String title;

  //Allows Todo card to be dismissable horizontally
  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  _MessagesState(this.title);
  Future<String> permissionStatusFuture;

  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";

  bool addtext = false;
  bool _isLoading = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String reminder = "Add Remainder";
  DateTime selectedDate = DateTime.now();
  final _todoDescriptionFormController = TextEditingController();
  //var  list;
  List<Todo> list = [];
  var COLORS = [
    Colors.deepOrange[900],
    Colors.deepOrange[700],
    Colors.deepOrange[500],
    Colors.deepOrange[300],
    Colors.deepOrange[100],
    //Colors.green[500]
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    var now = DateTime.now();
    var today = new DateTime(now.year, now.month, now.day);
    //minimumDate: DateTime.now().subtract(Duration(days: 1)),
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          child: RefreshIndicator(
            onRefresh: test,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: Container(
                    color: Colors.black,
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Column(
                      children: <Widget>[
                        Visibility(
                          visible: addtext,
                          child: Container(
                            color: Colors.deepOrange,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: new TextFormField(
                                    controller: _todoDescriptionFormController,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w400),
                                    autofocus: true,
                                    onSaved: (newValue) {
                                     // _todoDescriptionFormController.text.toString() = newValue;
                                    },
                                    decoration: const InputDecoration(
                                        //hintText: 'I have to...',

                                        border: InputBorder.none,
                                        fillColor: Colors.deepOrange,
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10, bottom: 15, top: 5),
                                      child: Text(
                                        reminder,
                                        style: TextStyle(
                                            color: Colors.white,
                                            backgroundColor: Colors.deepOrange),
                                      ),
                                    ),
                                    onTap: () {
                                      logoutDialog(
                                          context,
                                          _todoDescriptionFormController
                                              .value.text);
                                    })

                                /*   GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Text(reminder,style: TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.orange,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                                onTap: (){
                                  CupertinoDatePicker(
                                    minimumDate: today,
                                    minuteInterval: 1,
                                    mode: CupertinoDatePickerMode.dateAndTime,
                                    onDateTimeChanged: (DateTime dateTime) {
                                      print("dateTime: ${dateTime}");

                                      setState(() {
                                        reminder=dateTime as String;
                                      });

                                    },
                                  );

                                },),*/
                              ],
                            ),
                          ),
                        ),
                        Container(
                            //This is where the magic starts
                            child: Expanded(child: getTodosWidget())),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  logoutDialog(context, _todoDescriptionFormController) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        DateTime now = DateTime.now();
        String today = DateFormat('dd-MM-yyyy h:mm a').format(now);

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.white,
              width: 300.0,
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 150.0),
                      //color: Colors.white,
                      child: new CupertinoDatePicker(
                        initialDateTime:
                            new DateTime(now.year, now.month, now.day),
                        onDateTimeChanged: (DateTime newdate) {
                          DateFormat format1 = DateFormat('dd-MM-yyyy h:mm a');
                          today = format1.format(newdate);
                          print(newdate);
                        },
                        use24hFormat: false,
                        minimumYear: 2015,
                        maximumYear: 2025,
                        minuteInterval: 1,
                        minimumDate: DateTime.now().subtract(Duration(days: 2)),
                        mode: CupertinoDatePickerMode.dateAndTime,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, top: 10, bottom: 10),
                            child: new RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.white)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              textColor: Colors.black,
                              child: Text("Cancel".toUpperCase(),
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ),
                        onTap: () {
                          // Navigator.pop(context);
                        },
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, top: 10, bottom: 10),
                            child: new RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.white)),
                              onPressed: () {
                                final newTodo = Todo(
                                    description: _todoDescriptionFormController,
                                    datetime: today.toString());
                                if (newTodo.description.isNotEmpty) {
                                  /*Create new Todo object and make sure
                                              the Todo description is not empty,
                                              because what's the point of saving empty
                                              Todo
                                              */
                                  todoBloc.addTodo(newTodo);

                                  //permissionStatusFuture = getCheckNotificationPermStatus();
                                  //dismisses the bottomsheet
                                  //Navigator.pop(context);
                                  _firebaseMessaging.requestNotificationPermissions(
                                      const IosNotificationSettings(sound: true, badge: true, alert: true));
                                  _firebaseMessaging.onIosSettingsRegistered
                                      .listen((IosNotificationSettings settings) {
                                    print("Settings registered: $settings");
                                  });
                                  setState(() {
                                    addtext = false;

                                  });
                                }

                                Navigator.pop(context);
                              },
                              textColor: Colors.black,
                              child: Text("Ok".toUpperCase(),
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ),
                        onTap: () {
                          // Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddTodoSheet(BuildContext context) {
    final _todoDescriptionFormController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: new Container(
              color: Colors.transparent,
              child: new Container(
                height: 230,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoDescriptionFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'I have to...',
                                  labelText: 'New Todo',
                                  labelStyle: TextStyle(
                                      color: Colors.indigoAccent,
                                      fontWeight: FontWeight.w500)),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Empty description!';
                                }
                                return value.contains('')
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.save,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final newTodo = Todo(
                                      description:
                                          _todoDescriptionFormController
                                              .value.text);
                                  if (newTodo.description.isNotEmpty) {
                                    /*Create new Todo object and make sure
                                    the Todo description is not empty,
                                    because what's the point of saving empty
                                    Todo
                                    */
                                    todoBloc.addTodo(newTodo);

                                    //dismisses the bottomsheet
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _showTodoSearchSheet(BuildContext context) {
    final _todoSearchDescriptionFormController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: new Container(
              color: Colors.transparent,
              child: new Container(
                height: 230,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoSearchDescriptionFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: 'Search for todo...',
                                labelText: 'Search *',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                              validator: (String value) {
                                return value.contains('@')
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  /*This will get all todos
                                  that contains similar string
                                  in the textform
                                  */
                                  todoBloc.getTodos(
                                      query:
                                          _todoSearchDescriptionFormController
                                              .value.text);
                                  //dismisses the bottomsheet
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget getTodosWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (todos)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: todoBloc.todos,
      builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
        return getTodoCardWidget1(snapshot);
      },
    );
  }

  Widget getTodoCardWidget1(AsyncSnapshot<List<Todo>> snapshot) {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (snapshot.hasData) {
      /*Also handles whenever there's stream
      but returned returned 0 records of Todo from DB.
      If that the case show user that you have empty Todos
      */
      return snapshot.data.length != 0
          ? ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                setState(() {
                  final Todo item = list.removeAt(oldIndex);
                  list.insert(newIndex, item);
                  item.isDone = !item.isDone;
                  todoBloc.updateTodo(item);
                });
              },
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              children: List.generate(
                snapshot.data.length,
                (index) {
                  //list = snapshot.data.length;
                  list = snapshot.data;
                  final Widget dismissibleCard = new Dismissible(
                    background: Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.check,
                          size: 26.0,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.green[900],
                    ),
                    secondaryBackground: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.close,
                          size: 26.0,
                          color: Colors.red,
                        ),
                      ),
                      color: Colors.black,
                    ),
                    onDismissed: (direction) {
                      /*The magic
                    delete Todo item by ID whenever
                    the card is dismissed
                    */
                      /*   if(direction == DismissDirection.startToEnd){

                      }*/

                      if (direction == DismissDirection.endToStart) {
                        todoBloc.deleteTodoById(list[index].id);
                      } else if (direction == DismissDirection.startToEnd) {
                        list[index].isDone = !list[index].isDone;
                        /*
                            Another magic.
                            This will update Todo isDone with either
                            completed or not
                          */
                        todoBloc.updateTodo(list[index]);
                      }
                    },
                    direction: _dismissDirection,
                    key: new ObjectKey(list[index]),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey[200], width: 0.5),
                          borderRadius: BorderRadius.circular(1),
                        ),
                        color: list[index].isDone
                            ? Colors.black
                            : COLORS[new Random().nextInt(4)],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                list[index].description,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.5,
                                    fontFamily: 'RobotoMono',
                                    fontWeight: FontWeight.w500,
                                    decoration: list[index].isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, bottom: 5),
                              child: list[index].datetime.toString() != ""
                                  ? Text(
                                      list[index].datetime.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.5,
                                          fontFamily: 'RobotoMono',
                                          fontWeight: FontWeight.w500,
                                          decoration: list[index].isDone
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none),
                                    )
                                  : SizedBox(
                                      height: 0,
                                      width: 0,
                                    ),
                            ),
                          ],
                        )),
                  );
                  return dismissibleCard;
                },
              ),
            )
          : Container(
              child: Center(
              //this is used whenever there 0 Todo
              //in the data base
              child: noTodoMessageWidget(),
            ));
    } else {
      return Center(
        /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    //pull todos again
    todoBloc.getTodos();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget noTodoMessageWidget() {
    return Container(
      child: Text(
        "Pull down to create an item...",
        style: TextStyle(
            fontSize: 19, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }

  dispose() {
    /*close the stream in order
    to avoid memory leaks
    */
    todoBloc.dispose();
  }

  Future<bool> test() async {
    setState(() {
      addtext = true;
    });

    return addtext;
  }



  /// Checks the notification permission status
  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return permDenied;
        case PermissionStatus.granted:
          return permGranted;
        case PermissionStatus.unknown:
          return permUnknown;
        case PermissionStatus.provisional:
          return permProvisional;
        default:
          return null;
      }
    });
  }
}
