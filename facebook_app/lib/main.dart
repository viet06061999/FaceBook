import 'package:facebook_app/src/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(myChild: MyCenterWidget()),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {

  final Widget myChild;

  const MyHomePage({Key key, this.myChild}) : super(key: key);
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int counter = 0; // đây là data sẽ được truyền xuống widget con

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // truyền data `counter` từ widget MyHomePage xuống MyCenterWidget
      body: MyInheritedWidget(
        child: widget.myChild,
        myData: counter,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyCenterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      // tiếp tục truyền data từ widget MyCenterWidget xuống MyText
      child: MyText(),
    );
  }
}

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = MyInheritedWidget.of(context).myData;
    return Text('Tui là widget Text. Data của tui hiện tại là gui1: $counter');
  }
}

class MyInheritedWidget extends InheritedWidget {
  // 1
  MyInheritedWidget({Widget child, this.myData}) : super(child: child);

  // 2
  final int myData;

  // 3
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return myData != oldWidget.myData;
  }

  // 4
  static MyInheritedWidget of(BuildContext context) {
    // 5
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }
}
