import 'package:flutter/material.dart';
import 'package:flutter_juejin/models/category.dart';
import 'package:flutter_juejin/models/post.dart';
import 'package:flutter_juejin/widgets/post_list.dart';
import 'package:flutter_juejin/utils/index.dart';
import 'package:flutter_juejin/net/request.dart' as jjHttp;

class HomeBody extends StatefulWidget {
  HomeBody(this._category);

  final Category _category;

  @override
  State<StatefulWidget> createState() {
    return _HomeBodyState();
  }
}

class _HomeBodyState extends State<HomeBody> {
  List<Post> _list;
  String _lastCursor;
  bool _hasNextPage;

  Map<String, dynamic> get _params {
    return getListParams(category: widget._category);
  }

  Future<void> refreshPosts() {
    return queryList();
  }

  queryList() async {
    var data = await jjHttp.queryList(_params);
    // 由于数据请求是异步的，返回时，当前widget可能已经销毁了，在销毁的widget调用setState会报错。
    if (mounted) {
      setState(() {
        _list = data['posts'];
        _lastCursor = data['lastCursor'];
        _hasNextPage = data['hasNextPage'];
      });
    }
  }

  @override
  void initState() {
    queryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: PostList(_list),
      onRefresh: refreshPosts,
    );
  }
}
