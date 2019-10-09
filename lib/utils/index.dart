import 'package:flutter_juejin/models/category.dart';

List<Category> getCategory() {
  const category = {
    '推荐': '',
    '后端': '5562b419e4b00c57d9b94ae2',
    '前端': '',
    'Android': '',
    'ios': '',
    '人工智能': '',
    '开发工具': '',
    '代码人生': '',
    '阅读': ''
  };

  return category.keys
      .map((label) => Category(category[label], label))
      .toList();
}

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
