import 'dart:io';

import 'package:blog/core/error/exceptions.dart';
import 'package:blog/features/blog/data/models/blog.model.dart';
import 'package:blog/features/blog/data/datasources/remote/blog.remote.data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient _supabaseClient;

  BlogRemoteDataSourceImpl(
    SupabaseClient supabaseClient,
  ) : _supabaseClient = supabaseClient;

  @override
  Future<BlogModel> create(BlogModel blog) async {
    try {
      final response = await _supabaseClient
          .from('blogs')
          .insert(
            blog.toMap(),
          )
          .select();

      return BlogModel.fromMap(
        response.first,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await _supabaseClient.storage
          .from(
            'blog_images',
          )
          .upload(
            blog.id,
            image,
          );

      return _supabaseClient.storage
          .from(
            'blog_images',
          )
          .getPublicUrl(
            blog.id,
          );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> readAll() async {
    try {
      final data = await _supabaseClient
          .from(
            'blogs',
          )
          .select('*, profiles (name)');

      return data.map((item) => BlogModel.fromMap(item).copyWith(userName: item['profiles']['name'])).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
