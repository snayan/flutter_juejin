import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_juejin/models/destination.dart';
import 'package:flutter_juejin/widgets/destination_view.dart';

class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() {
    return _RootWidgetState();
  }
}

class _RootWidgetState extends State<RootWidget> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<AnimationController> _faders;
  List<Key> _keys;
  AnimationController _hider;

  List<BottomNavigationBarItem> get _bottomItem {
    return Destination.allDestinations.map((destination) {
      return BottomNavigationBarItem(
        icon: Icon(destination.icon),
        title: Text(destination.title),
        backgroundColor: destination.color,
      );
    }).toList();
  }

  List<Widget> get _destinationPages {
    final allDestinations = Destination.allDestinations;
    return List.generate(allDestinations.length, (index) {
      final destination = allDestinations[index];
      final child = FadeTransition(
        opacity: _faders[index].drive(CurveTween(curve: Curves.fastOutSlowIn)),
        child: KeyedSubtree(
          child: DestinationView(
            destination: destination,
            showBottomNavigator: () {
              _hider.forward();
            },
          ),
          key: _keys[index],
        ),
      );
      if (index == _currentIndex) {
        _faders[index].forward();
        return child;
      }
      _faders[index].reverse();
      if (_faders[index].isAnimating) {
        return IgnorePointer(child: child);
      }
      return Offstage(child: child);
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 1) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            _hider.forward();
            break;
          case ScrollDirection.reverse:
            _hider.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _faders = Destination.allDestinations.map((destination) {
      return AnimationController(
          vsync: this, duration: kThemeAnimationDuration);
    }).toList();
    _faders[_currentIndex].value = 1.0;
    _keys = List.generate(Destination.allDestinations.length, (_) {
      return GlobalKey();
    });
    _hider =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _hider.forward();
  }

  @override
  void dispose() {
    for (AnimationController _controller in _faders) {
      _controller.dispose();
    }
    _hider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final page = Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          fit: StackFit.expand,
          children: _destinationPages,
        ),
      ),
      bottomNavigationBar: ClipRect(
        child: SizeTransition(
          sizeFactor: _hider,
          axisAlignment: -1.0,
          child: BottomNavigationBar(
            items: _bottomItem,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
    return NotificationListener<ScrollNotification>(
      child: page,
      onNotification: _handleScrollNotification,
    );
  }
}
