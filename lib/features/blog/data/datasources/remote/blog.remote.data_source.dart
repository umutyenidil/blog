import 'dart:io';

import '../../models/blog.model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> create(BlogModel blog);

  Future<String> uploadImage({
    required File image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> readAll();
}
