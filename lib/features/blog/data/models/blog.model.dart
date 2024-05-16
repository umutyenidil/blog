import 'package:blog/features/blog/domain/entities/blog.entity.dart';

class BlogModel extends BlogEntity {
  BlogModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    super.userName,
  });

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      content: map['content'],
      imageUrl: map['image_url'],
      topics: (map['topics'] as List<dynamic>)
          .map((topic) => topic.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'user_id': super.userId,
      'title': super.title,
      'content': super.content,
      'image_url': super.imageUrl,
      'topics': super.topics,
    };
  }

  BlogModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    String? userName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      userName: userName ?? this.userName,
    );
  }
}
