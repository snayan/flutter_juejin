import 'package:flutter/material.dart';
import 'package:flutter_juejin/common/constraints.dart';
import 'package:flutter_juejin/models/destination.dart';
import './body.dart';

class Home extends StatefulWidget {
  Home(this._destination, {this.onTab});

  Destination _destination;
  VoidCallback onTab;
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final tabItems = Constraints.getAllCategory();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: tabItems.length,
    );
    _tabController.addListener(() {
      if (widget.onTab != null) {
        widget.onTab();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._destination.title),
        bottom: TabBar(
          tabs: tabItems.map((item) => Tab(text: item.label)).toList(),
          controller: _tabController,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabItems.map((item) => HomeBody(item)).toList(),
      ),
    );
  }
}
