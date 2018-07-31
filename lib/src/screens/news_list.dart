import 'package:flutter/material.dart';
//import 'package:news/src/blocs/stories_bloc.dart';
import '../blocs/stories_provider.dart';

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
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return Text('Still waiting on Ids');
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index) {
            return Text('${snapshot.data[index]}');
          },
        );

      },

    );
  }
}
