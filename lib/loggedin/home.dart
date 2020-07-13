import 'package:flutter/material.dart';

class AtleticoWidget extends StatefulWidget {
  AtleticoWidget({Key key}) : super(key: key);

  @override
  AtleticoWidgetState createState() => AtleticoWidgetState();
}

class AtleticoWidgetState extends State<AtleticoWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.person), child: null),
            ],
          ),
        ),
      ),
    );
  }
}
