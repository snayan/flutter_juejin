import 'package:flutter/material.dart';
import 'package:flutter_juejin/widgets/more_indicator.dart';

typedef ListViewCallback = Future<void> Function();
typedef ListViewItemBuilder = Widget Function(BuildContext, int);

class JJListView extends StatefulWidget {
  JJListView({
    Key key,
    this.onRefresh,
    this.onMore,
    this.hasMoreData,
    @required this.itemCount,
    @required this.itemBuilder,
  }) : super(key: key);

  final bool hasMoreData;
  final ListViewCallback onRefresh;
  final ListViewCallback onMore;
  final int itemCount;
  final ListViewItemBuilder itemBuilder;

  @override
  _JJListViewState createState() {
    return _JJListViewState();
  }
}

class _JJListViewState extends State<JJListView> {
  bool _showMoreIndicator = false;

  bool get _hasMore {
    return widget.onRefresh != null;
  }

  bool get _hasRefresh {
    return widget.onRefresh != null;
  }

  Future<void> triggerMore() {
    if (widget.hasMoreData) {
      widget.onMore();
    }
    return Future.value();
  }

  Widget _buildItem(BuildContext context, int index) {
    if (_hasMore && index == widget.itemCount) {
      return _buildMoreIndicator();
    }
    return widget.itemBuilder(context, index);
  }

  Widget _buildMoreIndicator() {
    return Center(
      child: Padding(
        child: widget.hasMoreData
            ? CircularProgressIndicator(
                strokeWidth: 1,
              )
            : Text("没有更多数据了"),
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = ListView.builder(
      itemCount: _hasMore ? widget.itemCount + 1 : widget.itemCount,
      itemBuilder: _buildItem,
    );
    if (_hasMore) {
      child = MoreIndicator(
        child: child,
        onMore: triggerMore,
      );
    }
    if (_hasRefresh) {
      child = RefreshIndicator(
        child: child,
        onRefresh: widget.onRefresh,
      );
    }
    return child;
  }
}
