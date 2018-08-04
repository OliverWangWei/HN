import 'package:flutter/material.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;

  final int depth;

  final Map<int, Future<ItemModel>> itemMap;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;

        final children = <Widget>[
          ListTile(
            title: buildText(item),
            subtitle: Text(item.by == "" ? "Deleted" : item.by),
            // depth of comment is determined by its level
            contentPadding: EdgeInsets.only(
              right: 16.0, // the default indent
              left: depth * 16.0,
            ),
          ),
          Divider(),
        ];

        // recursively create the kids of comment of this comment
        snapshot.data.kids.forEach((kidId) {
          children.add(Comment(itemMap: itemMap, itemId: kidId, depth: depth + 1));
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    final text= item.text
        .replaceAll('&#X27', " ' ")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');

    return Text(text);
  }
}
