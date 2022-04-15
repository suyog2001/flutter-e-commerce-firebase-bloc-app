import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/user_type_cubit/user_type_cubit.dart';
import '../../../data/repositories/firestore_repository.dart';
import '../../../constant/form_status.dart';
import '../cubit/login_cubit.dart';
import '../../signup/view/signup_page.dart';

class LoginPage extends StatelessWidget {
  static const String route = '/login';
  static Page page() => MaterialPage<void>(child: LoginPage());
  LoginPage({Key? key}) : super(key: key);
  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
          authenticationRepository: context.read<AuthenticationRepository>()),
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
                  const _EmailWidget(),
                  const _PasswordWidget(),
                  const SizedBox(height: 20),
                  const _UserTypeDropDown(),
                  _LoginSubmitButton(loginFormKey: _loginFormKey),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push<void>(
                            MaterialPageRoute(builder: (_) => SignupPage()));
                      },
                      child: const Text('Signup'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UserTypeDropDown extends StatelessWidget {
  const _UserTypeDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserTypeCubit, UserType>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return DropdownButtonFormField<UserType>(
            value: state,
            decoration: const InputDecoration(label: Text('Type of User')),
            items: const [
              DropdownMenuItem(
                child: Text(''),
                value: UserType.none,
              ),
              DropdownMenuItem(
                child: Text('Customer'),
                value: UserType.customer,
              ),
              DropdownMenuItem(
                child: Text('Seller'),
                value: UserType.seller,
              ),
            ],
            validator: (value) {
              if (value == UserType.none) return 'Select type of User';
              return null;
            },
            onChanged: (value) {
              context.read<UserTypeCubit>().checkTypeOfUser(value!);
            });
      },
    );
  }
}

class _LoginSubmitButton extends StatelessWidget {
  const _LoginSubmitButton({
    Key? key,
    required GlobalKey<FormState> loginFormKey,
  })  : _loginFormKey = loginFormKey,
        super(key: key);

  final GlobalKey<FormState> _loginFormKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          (previous.formStatus != current.formStatus),
      builder: (context, state) {
        if (state.formStatus is FormSubmmitingStatus) {
          return const CircularProgressIndicator();
        } else {
          return ElevatedButton(
              onPressed: () {
                if (_loginFormKey.currentState!.validate()) {
                  context.read<LoginCubit>().onLoginSubmit();
                }
              },
              child: const Text('Login'));
        }
      },
    );
  }
}

class _PasswordWidget extends StatelessWidget {
  const _PasswordWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          validator: (value) {
            if (state.isValidPassword) {
              return 'Password is too Short';
            }
            return null;
          },
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(label: Text('Password')),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        );
      },
    );
  }
}

class _EmailWidget extends StatelessWidget {
  const _EmailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          validator: (value) {
            if (!state.isValidEmail) {
              return 'Invalid Email Address';
            }
            return null;
          },
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(label: Text('Email')),
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}
