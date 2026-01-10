class UserModels {
  String name;
  String email;
  String uid;

  UserModels({
    required this.name,
    required this.email,
    required this.uid,
  });

  factory UserModels.fromJson(Map<String, dynamic> json) {
    return UserModels(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      uid: json['uid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
    };
  }
}