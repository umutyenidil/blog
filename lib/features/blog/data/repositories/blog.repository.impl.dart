import 'dart:io';

import 'package:blog/core/error/exceptions.dart';
import 'package:blog/core/error/failures.dart';
import 'package:blog/features/blog/data/datasources/remote/blog.remote.data_source.dart';
import 'package:blog/features/blog/data/models/blog.model.dart';
import 'package:blog/features/blog/domain/entities/blog.entity.dart';
import 'package:blog/features/blog/domain/repositories/blog.repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource _blogRemoteDataSource;

  BlogRepositoryImpl(
    BlogRemoteDataSource blogRemoteDataSource,
  ) : _blogRemoteDataSource = blogRemoteDataSource;

  @override
  Future<Either<Failure, BlogEntity>> create({
    required String userId,
    required File image,
    required List<String> topics,
    required String title,
    required String content,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v4(),
        userId: userId,
        imageUrl: '',
        topics: topics,
        title: title,
        content: content,
      );

      final String imageUrl = await _blogRemoteDataSource.uploadImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      BlogModel blog = await _blogRemoteDataSource.create(blogModel);

      return right(blog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> readAll() async {
    try {
      final data = await _blogRemoteDataSource.readAll();

      return right(data);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
