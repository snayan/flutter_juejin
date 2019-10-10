import 'package:flutter_juejin/models/category.dart';

enum ImageIconName {
  favorite_small,
  comment_small,
}

class Constraints {
  static const IMAGE_PREFIX = 'https://b-gold-cdn.xitu.io/v3/static/img/';

  static String getListQueryIdByCategory(Category category) {
    if (category.label == '') {
      return '21207e9ddb1de777adeaca7a2fb38030';
    } else {
      return '653b587c5c7c8a00ddf67fc66f989d42';
    }
  }

  static String getTagQueryId() {
    return '801e22bdc908798e1c828ba6b71a9fd9';
  }

  static String getImageIconByName(ImageIconName name) {
    switch (name) {
      case ImageIconName.comment_small:
        return '${IMAGE_PREFIX}comment.4d5744f.svg';
      case ImageIconName.favorite_small:
        return '${IMAGE_PREFIX}zan.e9d7698.svg';
      default:
        return null;
    }
  }

  static List<Category> getAllCategory() {
    const category = {
      '推荐': null,
      '后端': '5562b419e4b00c57d9b94ae2',
      '前端': '5562b415e4b00c57d9b94ac8',
      'Android': '5562b410e4b00c57d9b94a92',
      'ios': '5562b405e4b00c57d9b94a41',
      '人工智能': '57be7c18128fe1005fa902de',
      '开发工具': '5562b422e4b00c57d9b94b53',
      '代码人生': '5c9c7cca1b117f3c60fee548',
      '阅读': '5562b428e4b00c57d9b94b9d'
    };

    return category.keys
        .map((label) => Category(category[label], label))
        .toList();
  }
}
