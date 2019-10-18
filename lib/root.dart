import 'package:flutter/material.dart';
import 'package:flutter_juejin/models/destination.dart';
import 'package:flutter_juejin/widgets/destination_view.dart';

class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() {
    return _RootWidgetState();
  }
}

class _RootWidgetState extends State<RootWidget> {
  int _currentIndex = 0;

  List<BottomNavigationBarItem> get _bottomItem {
    return Destination.allDestinations.map((destination) {
      return BottomNavigationBarItem(
        icon: Icon(destination.icon),
        title: Text(destination.title),
        backgroundColor: destination.color,
      );
    }).toList();
  }

  List<Widget> get _destinationPages {
    return Destination.allDestinations.map((destination) {
      return DestinationView(destination);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          children: _destinationPages,
          index: _currentIndex,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomItem,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
