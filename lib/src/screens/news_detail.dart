import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/comment.dart';
import '../models/item_model.dart';
import '../blocs/comments_provider.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('News Detial'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading');
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Loading');
            }

            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));

    final commentList = item.kids.map((kidId) {
      // These're the top-level comments of this story
      return Comment(itemId: kidId, itemMap: itemMap, depth: 1);
    }).toList();

    return ListView(
      // to create a fix size of ListView
      children: children + commentList,
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(15.0),
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
