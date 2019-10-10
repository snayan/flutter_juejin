import 'package:flutter_juejin/common/constraints.dart';
import 'package:flutter_juejin/models/category.dart';
import 'package:flutter_juejin/models/tag.dart';

DateTime parseDateTime(dynamic rawValue) {
  final type = rawValue.runtimeType;
  if (type == DateTime) {
    return rawValue;
  } else if (type == String) {
    return DateTime.tryParse(rawValue);
  }
  return null;
}

String ensureSlash(String value) {
  if (value.startsWith('/')) {
    return value;
  }
  return '/$value';
}

String formatCount(int count) {
  if (count < 1000) {
    return count.toString();
  }
  return '${(count / 1000).floor()}k';
}

String formatDate(DateTime d) {
  var now = DateTime.now();
  var difference = now.difference(d);
  if (difference.inDays > 0) {
    return '${difference.inDays}天前';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}小时前';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}分钟前';
  } else {
    return '${difference.inSeconds}秒前';
  }
}

Map<String, dynamic> getQueryParams({
  Category category,
  List<Tag> tags,
  String queryId,
}) {
  return {
    'extensions': {
      'query': {
        'id': queryId,
      }
    },
    'variables': {
      'first': 20,
      'category': category?.id,
      'order': 'POPULAR',
    }
  };
}

Map<String, dynamic> getListParams({
  Category category,
  List<Tag> tags,
}) {
  return getQueryParams(
    queryId: Constraints.getListQueryIdByCategory(category),
    category: category,
    tags: tags,
  );
}

Map<String, dynamic> getTagsParams({
  Category category,
  List<Tag> tags,
}) {
  return getQueryParams(
    queryId: Constraints.getTagQueryId(),
    category: category,
    tags: tags,
  );
}
