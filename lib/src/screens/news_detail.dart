import 'package:flutter/material.dart';
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
      body: Center(
        child: buildBody(bloc),
      ),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    
  }
}
