part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogCreateSuccess extends BlogState {}

final class BlogReadAllBlogsSuccess extends BlogState{
  final List<BlogEntity> blogs;

  BlogReadAllBlogsSuccess(this.blogs);
}

final class BlogFailure extends BlogState {
  final String error;

  BlogFailure(this.error);
}
