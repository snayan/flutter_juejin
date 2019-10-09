import 'package:flutter/material.dart';
import 'package:flutter_juejin/utils/index.dart';
import 'package:flutter_juejin/widgets/post_list.dart';

class Home extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final tabItems = getCategory();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabItems.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        bottom: TabBar(
          tabs: tabItems.map((item) => Tab(text: item.label)).toList(),
          controller: _tabController,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabItems.map((item) => PostList(item)).toList(),
      ),
    );
  }
}
