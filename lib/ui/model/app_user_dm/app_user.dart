class AppUser {
  static const String collectionName = "users";
  static AppUser? currentUser;
  String? id;
  String? email;
  String? userName;

  AppUser({required this.id, required this.email, required this.userName});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    userName = json["userName"];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "userName": userName,
  };
}
