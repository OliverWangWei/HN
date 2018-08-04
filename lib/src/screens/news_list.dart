import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final bloc = StoriesProvider.of(context);

    // bad code : to invoke http request and add top ids


    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds, // listen this stream to fetch latest todIds
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Refresh(
          child: ListView.builder( // build listView
            itemCount: snapshot.data.length, // the length of topIds
            itemBuilder: (context, int index) { // iterates the topIds

              // insert specific id into sink
              bloc.fetchItemById.add(snapshot.data[index]);

              return NewsListTile(
                itemId: snapshot.data[index],
              );
            },
          ),

        );
      },
    );
  }
}
