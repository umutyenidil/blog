import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/secrets/app.secrets.dart';
import 'package:blog/features/auth/data/data_sources/remote/auth.remote.data_source.dart';
import 'package:blog/features/auth/data/data_sources/remote/auth.remote.data_source.impl.dart';
import 'package:blog/features/auth/data/repositories/auth.repository.impl.dart';
import 'package:blog/features/auth/domain/repositories/auth.repository.dart';
import 'package:blog/features/auth/domain/usecases/current_user.usecase.dart';
import 'package:blog/features/auth/domain/usecases/login.usecase.dart';
import 'package:blog/features/auth/domain/usecases/register.usecase.dart';
import 'package:blog/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:blog/features/blog/data/datasources/remote/blog.remote.data_source.dart';
import 'package:blog/features/blog/data/datasources/remote/blog.remote.data_source.impl.dart';
import 'package:blog/features/blog/data/repositories/blog.repository.impl.dart';
import 'package:blog/features/blog/domain/usecases/create_blog.usecase.dart';
import 'package:blog/features/blog/domain/usecases/read_all_blogs.usecase.dart';
import 'package:blog/features/blog/presentation/blocs/blog/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/blog/domain/repositories/blog.repository.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  Supabase supabase = await Supabase.initialize(
    url: AppSecrets.SUPABASE_URL,
    anonKey: AppSecrets.SUPABASE_ANON_KEY,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton<AppUserCubit>(
    () => AppUserCubit(),
  );
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
    ..registerFactory<CurrentUserUseCase>(
      () => CurrentUserUseCase(
        serviceLocator<AuthRepository>(),
      ),
    )
    //  Blocs
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        registerUseCase: serviceLocator<RegisterUseCase>(),
        loginUseCase: serviceLocator<LoginUseCase>(),
        currentUserUseCase: serviceLocator<CurrentUserUseCase>(),
        appUserCubit: serviceLocator<AppUserCubit>(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    //  data sources
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator<SupabaseClient>(),
      ),
    )
    //  repositories
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator<BlogRemoteDataSource>(),
      ),
    )
    //  usecases
    ..registerFactory<CreateBlogUseCase>(
      () => CreateBlogUseCase(
        serviceLocator<BlogRepository>(),
      ),
    )
    ..registerFactory<ReadAllBlogsUseCase>(
      () => ReadAllBlogsUseCase(
        serviceLocator<BlogRepository>(),
      ),
    )
    //  blocs
    ..registerLazySingleton<BlogBloc>(
      () => BlogBloc(
        createBlocUseCase: serviceLocator<CreateBlogUseCase>(),
        readAllBlogsUseCase: serviceLocator<ReadAllBlogsUseCase>(),
      ),
    );
}
