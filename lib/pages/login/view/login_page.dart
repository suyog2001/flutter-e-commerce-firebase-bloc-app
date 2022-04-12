import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/constant/form_status.dart';
import 'package:flutter_e_commerce_app/pages/login/cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  static const String route = '/login';
  static Page page() => MaterialPage<void>(child: LoginPage());
  LoginPage({Key? key}) : super(key: key);
  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context)),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          final currentformStatus = state.formStatus;
          if (currentformStatus is FormSubmissionFailedStatus) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                  SnackBar(content: Text(currentformStatus.errorMessage)));
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Login Page'), centerTitle: true),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _loginFormKey,
              child: Column(
                children: [
                  const EmailWidget(),
                  const PasswordWidget(),
                  const SizedBox(height: 20),
                  LoginSubmitButton(loginFormKey: _loginFormKey)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginSubmitButton extends StatelessWidget {
  const LoginSubmitButton({
    Key? key,
    required GlobalKey<FormState> loginFormKey,
  })  : _loginFormKey = loginFormKey,
        super(key: key);

  final GlobalKey<FormState> _loginFormKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state.formStatus is FormSubmmitingStatus) {
          return const CircularProgressIndicator();
        }
        return ElevatedButton(
            onPressed: () {
              if (_loginFormKey.currentState!.validate()) {
                context.read<LoginCubit>().onLoginSubmit();
              }
            },
            child: const Text('Login'));
      },
    );
  }
}

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) {
            if (state.isValidPassword) {
              return 'Password is too Short';
            }
            return null;
          },
          onChanged: (value) {
            context.read<LoginCubit>().passwordChanged(value);
          },
          decoration: const InputDecoration(label: Text('Password')),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        );
      },
    );
  }
}

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) {
            if (!state.isValidEmail) {
              return 'Invalid Email Address';
            }
            return null;
          },
          onChanged: (value) {
            context.read<LoginCubit>().emailChanged(value);
          },
          decoration: const InputDecoration(label: Text('Email')),
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}
