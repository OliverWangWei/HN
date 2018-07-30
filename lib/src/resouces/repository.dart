import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {

  // upper cast to Source
  List<Source> _sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> _caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return _sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {

    ItemModel item;
    Source source;

    // if there is a source has the item
    for (source in _sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        // if u have then break else keep searching next source
        break;
      }
      
    }

    // put the item into Db
    for (var cache in _caches) {

      try {
        source as NewsDbProvider;
        cache.addItem(item);
      } catch (e) {
        print(e);
      }
    }

    return item;
  }
}

abstract class Source {
  
  Future<List<int>> fetchTopIds();

  Future<ItemModel> fetchItem(int id);
  
}

abstract class Cache {

  Future<int> addItem(ItemModel item);

}
