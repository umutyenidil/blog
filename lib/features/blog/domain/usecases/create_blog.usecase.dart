import 'dart:io';

import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/blog/domain/entities/blog.entity.dart';
import 'package:blog/features/blog/domain/repositories/blog.repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateBlogUseCase implements UseCase<BlogEntity, CreateBlogParams> {
  final BlogRepository _blogRepository;

  CreateBlogUseCase(
    BlogRepository blogRepository,
  ) : _blogRepository = blogRepository;

  @override
  Future<Either<Failure, BlogEntity>> call(CreateBlogParams params) async {
    return await _blogRepository.create(
      userId: params.userId,
      image: params.image,
      topics: params.topics,
      title: params.title,
      content: params.content,
    );
  }
}

class CreateBlogParams {
  final String userId;
  final File image;
  final List<String> topics;
  final String title;
  final String content;

  CreateBlogParams({
    required this.userId,
    required this.image,
    required this.topics,
    required this.title,
    required this.content,
  });
}
