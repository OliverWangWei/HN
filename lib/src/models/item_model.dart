import 'dart:convert';

class ItemModel {

  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final String url;
  final List<dynamic> kids;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'],
        by = parsedJson['by'],
        text = parsedJson['text'] ?? '',
        time = parsedJson['time'],
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'],
        url = parsedJson['url'],
        kids = parsedJson['kids'] ?? [],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'] ?? 0;

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] == 1,
        type = parsedJson['type'],
        by = parsedJson['by'],
        text = parsedJson['text'],
        time = parsedJson['time'],
        dead = parsedJson['dead'] == 1,
        parent = parsedJson['parent'],
        url = parsedJson['url'],
        kids = jsonDecode(parsedJson['kids']),
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      "id": id,
      "type": type,
      "by": by,
      "text": text,
      "time": time,
      "parent": parent,
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
      "deleted": deleted ? 1 : 0,
      "dead": dead ? 1 : 0,
      "kids": jsonEncode(kids),
    };
  }
}
