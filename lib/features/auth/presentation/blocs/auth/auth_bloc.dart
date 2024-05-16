import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/common/entities/user.entity.dart';
import 'package:blog/features/auth/domain/usecases/login.usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/current_user.usecase.dart';
import '../../../domain/usecases/register.usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final CurrentUserUseCase _currentUserUseCase;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required RegisterUseCase registerUseCase,
    required LoginUseCase loginUseCase,
    required CurrentUserUseCase currentUserUseCase,
    required AppUserCubit appUserCubit,
  })  : _registerUseCase = registerUseCase,
        _loginUseCase = loginUseCase,
        _currentUserUseCase = currentUserUseCase,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
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
      (user) => _emitAuthSuccess(user, emit),
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
      (user) => _emitAuthSuccess(user, emit),
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
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(
    UserEntity user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
