import 'package:flutter/material.dart';
import 'package:flutter_juejin/models/category.dart';
import 'package:flutter_juejin/models/post.dart';
import 'package:flutter_juejin/net/request.dart' as jjHttp;
import 'package:flutter_juejin/utils/index.dart';
import 'package:flutter_juejin/widgets/post_item.dart';

class PostList extends StatefulWidget {
  PostList(this._category);

  final Category _category;

  @override
  _PostListState createState() {
    return _PostListState();
  }
}

class _PostListState extends State<PostList> {
  List<Post> _list;
  String _lastCursor;
  bool _hasNextPage;

  Map<String, dynamic> get _params {
    return getListParams(category: widget._category);
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_list == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      itemCount: _list?.length ?? 0,
      itemBuilder: (BuildContext context, int i) => PostItem(_list[i]),
    );
  }
}
