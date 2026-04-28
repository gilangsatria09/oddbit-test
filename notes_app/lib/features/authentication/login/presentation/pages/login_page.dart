import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/bloc/base_request_state.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/features/authentication/login/domain/params/params.dart';
import 'package:notes_app/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:notes_app/gen/assets.gen.dart';
import 'package:notes_app/shared_ui/shared_ui.dart';
import 'package:notes_app/shared_ui/theme/app_text_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BasePage<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginBloc _loginBloc;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loginBloc = context.read<LoginBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            state.loginState.maybeWhen(
              failed: (failure) => showSnackBar(failure.message, isError: true),
              loaded: (data) => AppRouter.homeRoutes.goToHomePage(context),
              orElse: () {},
            );
          },
          listenWhen: (previous, current) =>
              previous.loginState != current.loginState,
        ),
      ],
      child: Scaffold(body: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return ScrollableBody(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Assets.images.png.notepad.image(width: 82, height: 82),
          Text(
            'YourNotes',
            textAlign: TextAlign.center,
            style: AppTextStyle.headings.h4.bold.textStyle,
          ),
          _formSection(context),
          _buttonState(context),
          _registerSection(context),
        ],
      ),
    );
  }

  Widget _formSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,

      children: [
        BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) =>
              previous.username != current.username,
          builder: (context, state) {
            return AppTextField(
              controller: _usernameController,
              hintText: 'Username',
              errorText: state.usernameError,
              onChanged: (value) {
                _loginBloc.add(LoginEvent.usernameChanged(value));
              },
            );
          },
        ),
        BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) =>
              previous.password != current.password,
          builder: (context, state) {
            return PasswordTextField(
              controller: _passwordController,
              errorText: state.passwordError,
              onChanged: (value) {
                _loginBloc.add(LoginEvent.passwordChanged(value));
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buttonState(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.loginState.maybeWhen(
          loading: () => _buttonLogin(context, state.canLogin, true),
          orElse: () => _buttonLogin(context, state.canLogin, false),
        );
      },
    );
  }

  Widget _buttonLogin(BuildContext context, bool canLogin, bool isLoading) {
    return AppFilledButton(
      label: 'Login',
      isLoading: isLoading,
      onPressed: canLogin
          ? () {
              _loginBloc.add(
                LoginEvent.login(
                  LoginParams(
                    username: _usernameController.text,
                    password: _passwordController.text,
                  ),
                ),
              );
            }
          : null,
    );
  }

  Widget _registerSection(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(child: Text('Don\'t have an account? ')),
          WidgetSpan(
            child: TextButton(
              onPressed: () async {
                final result = await AppRouter.registerRoutes
                    .goToRegisterPage<String>(
                      context,
                      type: NavigationType.pushNamed,
                    );
                if (result != null && mounted) showSnackBar(result);
              },
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                minimumSize: WidgetStatePropertyAll(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text('Register Now.'),
            ),
          ),
        ],
      ),
      style: AppTextStyle.paragraphs.medium.regular.textStyle,
      textAlign: TextAlign.center,
    );
  }
}
