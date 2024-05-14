import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/entities/user.entity.dart';
import 'package:blog/features/auth/domain/repositories/auth.repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository _authRepository;

  const LoginUseCase(
    AuthRepository authRepository,
  ) : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(
    LoginParams params,
  ) async {
    return await _authRepository.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
