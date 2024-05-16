import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/common/entities/user.entity.dart';
import 'package:blog/features/auth/domain/repositories/auth.repository.dart';
import 'package:fpdart/fpdart.dart';

class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository _authRepository;

  const RegisterUseCase(
    AuthRepository authRepository,
  ) : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(
    RegisterParams params,
  ) async {
    return await _authRepository.registerWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
