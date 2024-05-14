import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/entities/user.entity.dart';
import 'package:blog/features/auth/domain/repositories/auth.repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUserUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository _authRepository;

  CurrentUserUseCase(
    AuthRepository authRepository,
  ) : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(void params) async {
    return await _authRepository.currentUser();
  }
}
