import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_juejin/models/post.dart';
import 'package:flutter_juejin/utils/index.dart';
import 'package:flutter_juejin/common/constraints.dart';

class PostItem extends StatelessWidget {
  final Post _post;
  final void Function(Post) onTap;

  PostItem(this._post, {this.onTap});

  String get _tags {
    return _post.tags?.map((e) => e.name)?.join(' / ');
  }

  String get _author {
    return _post.author?.username;
  }

  String get _likeCount {
    return formatCount(_post.likeCount ?? 0);
  }

  String get _commentCount {
    return formatCount(_post.commentCount ?? 0);
  }

  String get _createAt {
    return formatDate(_post.createAt);
  }

  _buildCount(BuildContext context, String image, String count) {
    var theme = Theme.of(context);
    return Container(
      height: 24,
      padding: EdgeInsets.symmetric(horizontal: 9.6, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Color(0xffedeeef),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.network(image),
          SizedBox(width: 2),
          Text(
            count,
            style: theme.textTheme.caption,
          ),
        ],
      ),
    );
  }

  _buildInfo(BuildContext context) {
    var theme = Theme.of(context);
    var child = TextSpan(
      text: '专栏',
      style: theme.textTheme.caption.copyWith(
        color: Color(0xffb71ed7),
      ),
      children: [
        TextSpan(
          text: ' · $_author · $_createAt · $_tags',
          style: theme.textTheme.caption,
        ),
      ],
    );
    if (_post.hot) {
      child = TextSpan(
        text: '荐',
        style: theme.textTheme.caption.copyWith(
          color: Color(0xffff7700),
        ),
        children: [
          TextSpan(
            text: ' · ',
          ),
          child,
        ],
      );
    }
    return Text.rich(child);
  }

  _buildTitle(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(top: 6, bottom: 12),
      child: Text(
        _post.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.subhead,
      ),
    );
  }

  _buildData(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCount(
          context,
          Constraints.getImageIconByName(ImageIconName.favorite_small),
          _likeCount,
        ),
        _buildCount(
          context,
          Constraints.getImageIconByName(ImageIconName.comment_small),
          _commentCount,
        ),
      ],
    );
  }

  _buildPost(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfo(context),
          _buildTitle(context),
          _buildData(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: _buildPost(context),
      ),
      onTap: () {
        onTap(_post);
      },
    );
  }
}
