class User {
  String name;
  String imageUrl;

  User(
    this.name,
    this.imageUrl,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json["name"],
      json["image_url"] ?? "",
    );
  }
}
