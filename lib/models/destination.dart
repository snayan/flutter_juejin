import 'package:flutter/material.dart';

enum DestinationPage {
  home,
  pins,
  topics,
  books,
  events,
}

class Destination {
  Destination(this.page, this.title, this.icon, this.color);

  final DestinationPage page;
  final String title;
  final IconData icon;
  final MaterialColor color;

  ThemeData theme(BuildContext context) {
    var theme = Theme.of(context);
    return theme.copyWith(
        primaryColor: color, scaffoldBackgroundColor: color[50]);
  }

  static List<Destination> get allDestinations {
    return <Destination>[
      Destination(DestinationPage.home, '首页', Icons.home, Colors.blue),
      Destination(DestinationPage.pins, '沸点', Icons.toys, Colors.cyan),
      Destination(DestinationPage.topics, '话题', Icons.chat, Colors.orange),
      Destination(DestinationPage.books, '小册', Icons.book, Colors.teal),
      Destination(DestinationPage.events, '活动', Icons.event, Colors.green),
    ];
  }
}
