import 'package:blog/core/constants/edge_insets.constants.dart';
import 'package:blog/core/constants/text_style.constants.dart';
import 'package:blog/core/theme/app_palette.dart';
import 'package:blog/core/utils/show_loading.dart';
import 'package:blog/core/utils/show_snackbar.dart';
import 'package:blog/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:blog/features/auth/presentation/pages/register.page.dart';
import 'package:blog/features/auth/presentation/widgets/input.dart';
import 'package:blog/features/auth/presentation/widgets/linear_gradient.button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (_) => const LoginPage(),
      );

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailAddressController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsConstants.ALL12,
          child: BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsetsConstants.B48,
                      child: Text(
                        'Login.',
                        style: TextStyleConstants.BOLD44,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsConstants.B12,
                      child: Input(
                        controller: _emailAddressController,
                        hint: 'Email Address',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsConstants.B12,
                      child: Input(
                        isObscure: true,
                        controller: _passwordController,
                        hint: 'Password',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsConstants.B12,
                      child: LinearGradientButton(
                        label: 'Login',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthLogin(
                                    email: _emailAddressController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                );
                          }
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          RegisterPage.route(),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Register',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppPallete.gradient2,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            listener: (BuildContext context, AuthState state) {
              if (state is AuthLoading) {
                showLoading(context);
              }
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              }
            },
            listenWhen: (AuthState prevState,AuthState state) {
              if(prevState is AuthLoading){
                Navigator.of(context).pop();
              }
              return true;
            },
          ),
        ),
      ),
    );
  }
}
