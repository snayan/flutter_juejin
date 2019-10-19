import 'package:flutter/material.dart';
import 'package:flutter_juejin/models/destination.dart';
import 'package:flutter_juejin/pages/books/index.dart';
import 'package:flutter_juejin/pages/events/index.dart';
import 'package:flutter_juejin/pages/home/index.dart';
import 'package:flutter_juejin/pages/pins/index.dart';
import 'package:flutter_juejin/pages/topics/index.dart';

class DestinationView extends StatefulWidget {
  DestinationView(this._destination);

  final Destination _destination;

  @override
  _DestinationViewState createState() {
    return _DestinationViewState();
  }
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    final destination = widget._destination;
    Widget child;

    switch (destination.page) {
      case DestinationPage.pins:
        child = Pins(destination);
        break;
      case DestinationPage.topics:
        child = Topics(destination);
        break;
      case DestinationPage.books:
        child = Books(destination);
        break;
      case DestinationPage.events:
        child = Events(destination);
        break;
      default:
        child = Home(destination);
    }
    return Theme(
      child: child,
      data: destination.theme(context),
    );
  }
}
