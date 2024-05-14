import 'package:blog/core/secrets/app.secrets.dart';
import 'package:blog/features/auth/data/data_sources/remote/auth.remote.data_source.dart';
import 'package:blog/features/auth/data/data_sources/remote/auth.remote.data_source.impl.dart';
import 'package:blog/features/auth/data/repositories/auth.repository.impl.dart';
import 'package:blog/features/auth/domain/repositories/auth.repository.dart';
import 'package:blog/features/auth/domain/usecases/login.usecase.dart';
import 'package:blog/features/auth/domain/usecases/register.usecase.dart';
import 'package:blog/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  Supabase supabase = await Supabase.initialize(
    url: AppSecrets.SUPABASE_URL,
    anonKey: AppSecrets.SUPABASE_ANON_KEY,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator
    //  Data Sources
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator<SupabaseClient>(),
      ),
    )
    //  Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator<AuthRemoteDataSource>(),
      ),
    )
    //  Usecases
    ..registerFactory<RegisterUseCase>(
      () => RegisterUseCase(
        serviceLocator<AuthRepository>(),
      ),
    )
    ..registerFactory<LoginUseCase>(
      () => LoginUseCase(
        serviceLocator<AuthRepository>(),
      ),
    )
    //  Blocs
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        registerUseCase: serviceLocator<RegisterUseCase>(),
        loginUseCase: serviceLocator<LoginUseCase>(),
      ),
    );
}
