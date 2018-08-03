import 'dart:async';

import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import '../widgets/loading_container.dart';

class NewsListTile extends StatelessWidget {

  // every list tile need to have the specific id to pull the corresponding ItemModel out in cache map
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      // listen to getItems stream and return FutureBuilder
      // as long as it emits Map<int, Future<ItemModel>> event
      stream: bloc.getItems,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        // before any event comes out
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          // listen to a future when a value return in some point of future the builder function is called
          future: snapshot.data[itemId], // Future<ItemModel>
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }
            // 返回ListTile
            return buildTile(context, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            print('${item.id} was tapped!!!!');
            //1. slash is not necessary here but it's good to distinguish
            //2. As we call this static method, the on Generate routes callback will be invoked
            // and the second argument will be wrapped into the settings which is the parameter of callback
            Navigator.pushNamed(context, '/${item.id}');
          },
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
