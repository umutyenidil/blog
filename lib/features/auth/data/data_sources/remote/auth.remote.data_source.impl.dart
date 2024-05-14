import 'package:blog/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/user.model.dart';
import 'auth.remote.data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSourceImpl(
    SupabaseClient supabaseClient,
  ) : _supabaseClient = supabaseClient;

  @override
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user == null) {
        throw const ServerException('user is null');
      }

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );

      if (response.user == null) {
        throw const ServerException('user is null');
      }

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Session? get currentUserSession => _supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession == null) {
        return null;
      }

      final userData = await _supabaseClient
          .from(
            'profiles',
          )
          .select(
            'id name',
          )
          .eq(
            'id',
            currentUserSession!.user.id,
          );

      return UserModel.fromJson(userData.first).copyWith(
        email: currentUserSession!.user.email,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
