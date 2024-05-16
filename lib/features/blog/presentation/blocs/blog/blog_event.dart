part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogCreate extends BlogEvent {
  final String userId;
  final File image;
  final List<String> topics;
  final String title;
  final String content;

  BlogCreate({
    required this.userId,
    required this.image,
    required this.topics,
    required this.title,
    required this.content,
  });
}

final class BlogReadAllBlogs extends BlogEvent {}
