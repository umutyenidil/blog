import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/entities/user.entity.dart';
import 'package:blog/features/auth/domain/usecases/login.usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/current_user.usecase.dart';
import '../../../domain/usecases/register.usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final CurrentUserUseCase _currentUserUseCase;

  AuthBloc({
    required RegisterUseCase registerUseCase,
    required LoginUseCase loginUseCase,
    required CurrentUserUseCase currentUserUseCase,
  })  : _registerUseCase = registerUseCase,
        _loginUseCase = loginUseCase,
        _currentUserUseCase = currentUserUseCase,
        super(AuthInitial()) {
    on<AuthRegister>(_onAuthRegister);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
  }

  void _onAuthIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _currentUserUseCase(NoParams());

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) {
        print(user);
      return emit(AuthSuccess(user));
      },
    );
  }

  void _onAuthRegister(
    AuthRegister event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _registerUseCase(RegisterParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (userId) => emit(AuthSuccess(userId)),
    );
  }

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _loginUseCase(LoginParams(
      email: event.email,
      password: event.password,
    ));

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (userId) => emit(AuthSuccess(userId)),
    );
  }
}
