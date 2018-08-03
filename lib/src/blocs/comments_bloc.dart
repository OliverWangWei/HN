import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import 'dart:async';
import '../resources/repository.dart';

class CommentsBloc {

  final _repository = Repository();
  final _commentFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  /// Streams Getter
  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  /// Sink Getter
  StreamSink<int> get fetchItemWithComments => _commentFetcher.sink;

  CommentsBloc() {
    _commentFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentFetcher);
  }

  _commentsTransformer() {
    // stream in with integer and stream out with Map<int, Future<ItemModel>>
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, int index) {
        // assign a future which returns by fetchItem to cache[id]
        cache[id] = _repository.fetchItem(id);
        // when future is resolved then then's callback will be invoked
        cache[id].then((ItemModel item) {
          // foreach item's kids property to insert all the kidId into sink
          // then recursively doing this stuff
          item.kids.forEach((kidId) => fetchItemWithComments.add(kidId));
        });
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _commentFetcher.close();
    _commentsOutput.close();
  }
}
