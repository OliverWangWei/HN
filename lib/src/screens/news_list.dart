import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';

class NewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    // bad code
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index) {

            bloc.fetchItemById.add(snapshot.data[index]);

            return NewsListTile(
              itemId: snapshot.data[index],
            );
          },
        );
      },
    );
  }
}
