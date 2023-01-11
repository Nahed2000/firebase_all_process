class Notes {
  late String id;
  late String title;
  late String info;

  Notes();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> maps = <String, dynamic>{};
    maps['title'] = title;
    maps['info'] = info;
    return maps;
  }

  Notes.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    info = map['info'];
  }
}
