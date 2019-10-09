class Category {
  Category(this.id, this.label);

  static Category fromJSON(Map<String, dynamic> json) {
    return Category(json['id'], json['name']);
  }

  String label;
  String id;
}
