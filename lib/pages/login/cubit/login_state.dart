part of 'login_cubit.dart';

class LoginState extends Equatable {
  bool get isValidPassword => password.length < 8;
  bool get isValidEmail => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
  const LoginState(
      {this.email = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  @override
  List<Object> get props => [email, password, formStatus];

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  String toString() =>
      'LoginState(email: $email, password: $password, formStatus: $formStatus)';
}
