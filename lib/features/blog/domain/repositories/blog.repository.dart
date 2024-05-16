import 'dart:io';

import 'package:blog/core/error/failures.dart';
import 'package:blog/features/blog/domain/entities/blog.entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> create({
    required String userId,
    required File image,
    required List<String> topics,
    required String title,
    required String content,
  });

  Future<Either<Failure, List<BlogEntity>>> readAll();
}
