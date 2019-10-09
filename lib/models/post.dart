import 'package:flutter_juejin/models/category.dart';
import 'package:flutter_juejin/models/tag.dart';
import 'package:flutter_juejin/models/user.dart';
import 'package:flutter_juejin/utils/index.dart';

class Post {
  String id;
  String title;
  String type;
  String description;
  String content;
  String screenshot;
  DateTime createAt;
  DateTime updateAt;
  DateTime lastCommentAt;
  Category category;
  List<Tag> tags;
  User author;
  int likeCount;
  int commentCount;
  bool hot;

  Post(
    this.id, {
    this.title,
    this.type,
    this.description,
    this.content,
    this.screenshot,
    this.createAt,
    this.updateAt,
    this.lastCommentAt,
    this.category,
    this.tags,
    this.author,
    this.likeCount,
    this.commentCount,
    this.hot,
  });

  static Post fromJson(Map<String, dynamic> json) {
    return Post(
      json['id'],
      title: json['title'],
      type: json['type'],
      description: json['content'],
      screenshot: json['screenshot'],
      createAt: parseDateTime(json['createdAt']),
      updateAt: parseDateTime(json['updatedAt']),
      lastCommentAt: parseDateTime(json['lastCommentTime']),
      category: Category.fromJSON(json),
      tags: (json['tags'] as List)?.map((tag) => Tag.fromJSON(tag))?.toList(),
      author: User.fromJSON(json['user']),
      likeCount: json['likeCount'] ?? 0,
      commentCount: json['commentsCount'] ?? 0,
      hot: json['hot'] ?? false,
    );
  }

  updateContent(String content) {
    this.content = content;
  }
}
