import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:blog/features/auth/presentation/pages/login.page.dart';
import 'package:blog/features/blog/presentation/pages/blogs.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, state) {
          if (state) {
            return const BlogsPage();
          }
          

          return const LoginPage();
        },
      ),
    );
  }
}
