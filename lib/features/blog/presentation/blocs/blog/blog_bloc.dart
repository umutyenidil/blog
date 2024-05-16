import 'dart:io';

import 'package:blog/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/blog.entity.dart';
import '../../../domain/usecases/create_blog.usecase.dart';
import '../../../domain/usecases/read_all_blogs.usecase.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final CreateBlogUseCase _createBlogUseCase;
  final ReadAllBlogsUseCase _readAllBlogsUseCase;

  BlogBloc({
    required CreateBlogUseCase createBlocUseCase,
    required ReadAllBlogsUseCase readAllBlogsUseCase,
  })  : _createBlogUseCase = createBlocUseCase,
        _readAllBlogsUseCase = readAllBlogsUseCase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogCreate>(_onBlogCreate);
    on<BlogReadAllBlogs>(_onBlogReadAllBlogs);
  }

  void _onBlogReadAllBlogs(
      BlogReadAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _readAllBlogsUseCase(NoParams());

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogReadAllBlogsSuccess(blogs)),
    );
  }

  void _onBlogCreate(BlogCreate event, Emitter<BlogState> emit) async {
    final res = await _createBlogUseCase(CreateBlogParams(
      userId: event.userId,
      image: event.image,
      topics: event.topics,
      title: event.title,
      content: event.content,
    ));

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogCreateSuccess()),
    );
  }
}
