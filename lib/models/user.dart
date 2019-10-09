class User {
  String id;
  String role;
  String username;
  String avatarHd;
  String avatarLarge;

  User(
    this.id,
    this.username, {
    role = 'guest',
    this.avatarHd,
    this.avatarLarge,
  });

  static User fromJSON(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['username'],
      role: json['role'],
      avatarHd: json['avatarHd'],
      avatarLarge: json['avatarLarge'],
    );
  }
}
