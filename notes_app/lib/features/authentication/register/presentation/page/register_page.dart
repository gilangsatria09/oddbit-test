import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/features/authentication/register/domain/params/params.dart';
import 'package:notes_app/features/authentication/register/presentation/bloc/register_bloc.dart';
import 'package:notes_app/shared_ui/shared_ui.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BasePage<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late RegisterBloc _registerBloc;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _registerBloc = context.read<RegisterBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            state.registerState.maybeWhen(
              failed: (failure) => showSnackBar(failure.message, isError: true),
              loaded: (data) => context.pop('Register success'),
              orElse: () {},
            );
          },
          listenWhen: (previous, current) =>
              previous.registerState != current.registerState,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('Register')),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return ScrollableBody(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 200),
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 82),
          _formField(context),
          _buttonRegister(context),
        ],
      ),
    );
  }

  Widget _formField(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<RegisterBloc, RegisterState>(
          buildWhen: (previous, current) =>
              previous.username != current.username ||
              previous.usernameError != current.usernameError,
          builder: (context, state) {
            return AppTextField(
              hintText: 'Username',
              controller: _usernameController,
              errorText: state.usernameError,
              onChanged: (value) {
                _registerBloc.add(RegisterEvent.usernameChanged(value));
              },
            );
          },
        ),
        BlocBuilder<RegisterBloc, RegisterState>(
          buildWhen: (previous, current) =>
              previous.password != current.password ||
              previous.passwordError != current.passwordError,
          builder: (context, state) {
            return PasswordTextField(
              controller: _passwordController,
              errorText: state.passwordError,
              onChanged: (value) {
                _registerBloc.add(RegisterEvent.passwordChanged(value));
              },
            );
          },
        ),
        BlocBuilder<RegisterBloc, RegisterState>(
          buildWhen: (previous, current) =>
              previous.confirmPassword != current.confirmPassword ||
              previous.confirmPasswordError != current.confirmPasswordError,
          builder: (context, state) {
            return PasswordTextField(
              hintText: 'Confirm Password',
              controller: _confirmPasswordController,
              errorText: state.confirmPasswordError,
              onChanged: (value) {
                _registerBloc.add(RegisterEvent.confirmPasswordChanged(value));
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buttonRegister(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return AppFilledButton(
          label: 'Register',
          isLoading: state.registerState.maybeWhen(
            loading: () => true,
            orElse: () => false,
          ),
          onPressed: state.canRegister
              ? () {
                  _registerBloc.add(
                    RegisterEvent.register(
                      RegisterParams(
                        username: _usernameController.text,
                        password: _passwordController.text,
                      ),
                    ),
                  );
                }
              : null,
        );
      },
    );
  }
}
