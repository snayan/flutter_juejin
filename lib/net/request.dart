import 'base.dart';
import 'package:flutter_juejin/models/post.dart';

queryList(Map<String, dynamic> body) async {
  var res = await BaseHttp.request("post", '/query', body: body);
  var items = res['data']['articleFeed']['items'];
  var posts = items['edges'] as List;
  var pageInfo = items['pageInfo'];
  return {
    'posts': posts.map((e) => Post.fromJson(e['node'])).toList(),
    'lastCursor': pageInfo['endCursor'],
    'hasNextPage': pageInfo['hasNextPage']
  };
}
