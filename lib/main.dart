import 'package:blog/app.dart';
import 'package:blog/core/secrets/app.secrets.dart';
import 'package:blog/features/auth/data/data_sources/remote/auth.remote.data_source.impl.dart';
import 'package:blog/features/auth/data/repositories/auth.repository.impl.dart';
import 'package:blog/features/auth/domain/usecases/register.usecase.dart';
import 'package:blog/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:blog/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
      ],
      child: const App(),
    ),
  );
}