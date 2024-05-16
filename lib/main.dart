import 'package:blog/app.dart';
import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:blog/features/blog/presentation/blocs/blog/blog_bloc.dart';
import 'package:blog/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<BlogBloc>(),
        )
      ],
      child: const App(),
    ),
  );
}
