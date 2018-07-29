import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';


class Repository {
  
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {

    // first fetch the item data from the db
    var item = await dbProvider.fetchItem(id);

    // if there is item data in db then return it
    if (item != null) {
      return item;
    }

    // else we fetch it from api
    item = await apiProvider.fetchItem(id);

    // and then put it into db
    dbProvider.addItem(item);

    // return item data
    return item;

  }

}