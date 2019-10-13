import 'package:flutter/material.dart';
import 'package:flutter_juejin/models/post.dart';
import 'package:flutter_juejin/widgets/post_item.dart';

class PostList extends StatelessWidget {
  PostList(this._list);

  final List<Post> _list;

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
