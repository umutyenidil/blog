import 'package:blog/core/error/exceptions.dart';
import 'package:blog/core/error/failures.dart';
import 'package:blog/features/auth/data/data_sources/remote/auth.remote.data_source.dart';
import 'package:blog/features/auth/data/models/user.model.dart';
import 'package:blog/features/auth/domain/entities/user.entity.dart';
import 'package:blog/features/auth/domain/repositories/auth.repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(
    AuthRemoteDataSource remoteDataSource,
  ) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await _remoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await _remoteDataSource.registerWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, UserEntity>> _getUser(
    Future<UserEntity> Function() fn,
  ) async {
    try {
      final userModel = await fn();

      return right(userModel);
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    try {
      UserModel? userModel = await _remoteDataSource.getCurrentUserData();

      if (userModel == null) {
        return left(Failure('user not logged in'));
      }

      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
