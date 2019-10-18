import 'package:flutter/material.dart';
import 'package:flutter_juejin/models/category.dart';
import 'package:flutter_juejin/models/post.dart';
import 'package:flutter_juejin/widgets/list_view.dart';
import 'package:flutter_juejin/widgets/post_item.dart';
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

class _HomeBodyState extends State<HomeBody>
    with AutomaticKeepAliveClientMixin<HomeBody> {
  List<Post> _list;
  String _lastCursor;
  bool _hasNextPage;

  Map<String, dynamic> get _params {
    return getListParams(category: widget._category, after: _lastCursor);
  }

  Future<void> refreshPosts() async {
    var params = getListParams(category: widget._category);
    var data = await jjHttp.queryList(params);
    // 由于数据请求是异步的，返回时，当前widget可能已经销毁了，在销毁的widget调用setState会报错。
    if (mounted) {
      setState(() {
        _list = data['posts'];
        _lastCursor = data['lastCursor'];
        _hasNextPage = data['hasNextPage'];
      });
    }
  }

  Future<void> getMorePosts() async {
    var params = getListParams(category: widget._category, after: _lastCursor);
    var data = await jjHttp.queryList(params);
    // 由于数据请求是异步的，返回时，当前widget可能已经销毁了，在销毁的widget调用setState会报错。
    if (mounted) {
      setState(() {
        _list.addAll(data['posts']);
        _lastCursor = data['lastCursor'];
        _hasNextPage = data['hasNextPage'];
      });
    }
  }

  @override
  void initState() {
    refreshPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_list == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return JJListView(
      onRefresh: refreshPosts,
      onMore: getMorePosts,
      hasMoreData: _hasNextPage ?? false,
      itemCount: _list?.length ?? 0,
      itemBuilder: (BuildContext context, int index) => PostItem(_list[index]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
