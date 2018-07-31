import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resouces/repository.dart';

class StoriesBloc {

  final _repository = Repository();

  final _topIds = PublishSubject<List<int>>();


  // Getters to Streams
  Observable<List<int>> get topIds => _topIds.stream;

  // get info from repo
  fetchTopIds() async {
    final List<int> ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  dispose() {
    _topIds.close();
  }


}
