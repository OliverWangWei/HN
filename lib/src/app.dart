import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'news!',
        onGenerateRoute: _routes,
      ),
    );
  }

  Route _routes(RouteSettings settings) {

    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return NewsList();
      });
    } else {
      return MaterialPageRoute(
        builder: (context) {
          // extract the item id from settings.name
          // and pass into NewsDetail
          // A fantastic location to do some initialization
          // or data fetching for NewsDetail

          final itemId = int.parse(settings.name.replaceFirst('/', ''));

          return NewsDetail(itemId: itemId);
        }
      );
    }


  }
}
