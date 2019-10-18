import 'package:flutter/material.dart';
import 'package:flutter_juejin/models/destination.dart';

class Events extends StatelessWidget {
  Events(this._destination);

  final Destination _destination;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_destination.title),
      ),
      body: Center(
        child: Text(_destination.title),
      ),
    );
  }
}
