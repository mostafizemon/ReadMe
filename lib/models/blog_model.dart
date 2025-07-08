class BlogModel {
  final int id;
  final String title;
  final String description;
  final User user;
  final int totalReadTime;
  final int likesCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlogModel({
    required this.id,
    required this.title,
    required this.description,
    required this.user,
    required this.totalReadTime,
    required this.likesCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      user: User.fromJson(json['user']),
      totalReadTime: json['total_read_time'],
      likesCount: json['likes_count'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String? profilePhotoUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profilePhotoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePhotoUrl: json['profile_photo_url'],
    );
  }
}
