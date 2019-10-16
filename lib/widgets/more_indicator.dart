import 'package:flutter/material.dart';

typedef MoreCallback = Future<void> Function();

enum MoreIndicatorMode {
  /// 到达distance位置，可以调用onMore，但是还未到达显示indicator
  more,

  ///  到达可以显示indictor的位置
  show,

  ///  onMore调用完成，或者往上滚动了，隐藏indicator
  dismiss,
}

class MoreIndicator extends StatefulWidget {
  MoreIndicator({
    Key key,
    @required this.child,
    @required this.onMore,
    this.distance = 20,
  })  : assert(child != null),
        assert(onMore != null),
        super(key: key);

  /// MoreIndicator child
  final Widget child;

  /// callback to get more data
  final MoreCallback onMore;

  /// trigger onMore callback when distance bottom
  final double distance;

  @override
  _ModeIndicatorState createState() {
    return _ModeIndicatorState();
  }
}

class _ModeIndicatorState extends State<MoreIndicator> {
  MoreIndicatorMode _mode;
  bool _isLoading = false;

  GlobalKey _key = GlobalKey();

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.metrics.axisDirection == AxisDirection.down) {
      if (notification.metrics.extentAfter <= widget.distance / 2) {
        _mode = MoreIndicatorMode.show;
      } else if (notification.metrics.extentAfter <= widget.distance) {
        _mode = MoreIndicatorMode.more;
      }
    } else if (notification.metrics.axisDirection == AxisDirection.up) {
      if (_mode == MoreIndicatorMode.show) {
        _mode = MoreIndicatorMode.dismiss;
      }
    }

    if (_mode == MoreIndicatorMode.more || _mode == MoreIndicatorMode.show) {
      _dispatchMore();
    }

    return false;
  }

  void _dispatchMore() {
    if (_isLoading) {
      return;
    }
    _isLoading = true;
    final Future<void> result = widget.onMore();
    assert(result != null);
    if (result == null) {
      return;
    }
    result.whenComplete(() {
      if (!mounted) {
        return;
      }
      _isLoading = false;
      if (_mode == MoreIndicatorMode.show) {
        _mode = MoreIndicatorMode.dismiss;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      key: _key,
      child: widget.child,
      onNotification: _handleScrollNotification,
    );
  }
}
