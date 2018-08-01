import 'dart:async';

import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import '../widgets/loading_container.dart';


class NewsListTile extends StatelessWidget {

// every list tile need to have the specific id to pull the ItemModel out in cache ma~p
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {

    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.getItems,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {

            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }

            return buildTile(itemSnapshot.data);
          },
        );

      },
    );

  }

  Widget buildTile(ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} votes'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.chat_bubble),
              Text('${item.descendants}'),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }

}
