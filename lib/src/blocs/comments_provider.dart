import 'package:flutter/material.dart';
import 'comments_bloc.dart';
export 'comments_bloc.dart';

class CommentsProvider extends InheritedWidget {

  final CommentsBloc _bloc;

  CommentsProvider({Key key, Widget child})
      : _bloc = CommentsBloc(),
        super(key: key, child: child);

  static CommentsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CommentsProvider)
            as CommentsProvider)
        ._bloc;
  }

  @override
  bool updateShouldNotify(_) => true;
}
