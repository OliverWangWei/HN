import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  /// StreamController
  final _repository = Repository();

  final _topIds = PublishSubject<List<int>>();

  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  final _itemsFetcher = PublishSubject<int>();

  /// Getters to Streams
  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get getItems => _itemsOutput.stream;

  /// Getters to Sinks
  StreamSink<int> get fetchItemById => _itemsFetcher.sink;

  StoriesBloc() {
    //create a single instance of ScanStreamTransformer to make sure every widget sharing
    //the same cache in ScanStreamTransformer

    // pipe the coming event into _itemsOutput
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  // get info from repo
  fetchTopIds() async {
    final List<int> ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache() {
    return _repository.clearCash();
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      // cache hold the reference of map, it will persist over and over again
      // index is number of times that ScanStreamTransformer invoked
      // id is the event stream in transformer
      (Map<int, Future<ItemModel>> cache, int id, index) {
        print('$index');
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{}, // empty map for initial state
    );
  }

  dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}
