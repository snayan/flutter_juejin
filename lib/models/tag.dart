class Tag {
  String name;
  String id;

  Tag(this.id, this.name);

  static Tag fromJSON(Map<String, dynamic> json) {
    return Tag(json['id'], json['title']);
  }
}
