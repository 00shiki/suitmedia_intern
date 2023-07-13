class ResponseUser {
  final List<dynamic> data;

  ResponseUser(this.data);

  factory ResponseUser.fromJson(Map<String, dynamic> json) =>
      ResponseUser(json["data"]);
}

class User {
  final String email;
  final String firstName;
  final String lastName;
  final String avatarUrl;
  User(this.email, this.firstName, this.lastName, this.avatarUrl);

  factory User.fromJson(Map<String, dynamic> json) => User(
      json["email"], json["first_name"], json["last_name"], json["avatar"]);
}
