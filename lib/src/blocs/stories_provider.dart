import 'package:flutter/material.dart';
import 'stories_bloc.dart';
export 'stories_bloc.dart'; // 當有任何程式引入該當案都會附帶此檔案

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({Key key, Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  static StoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;
  }

  @override
  bool updateShouldNotify(_) => true;
}
