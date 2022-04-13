part of 'signup_cubit.dart';

class SignupState extends Equatable {
  bool get isValidPassword => password.length < 8;
  bool get isValidEmail => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
  const SignupState(
      {this.email = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  @override
  List<Object> get props => [email, password, formStatus];

  SignupState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  String toString() =>
      'SignupState(email: $email, password: $password, formStatus: $formStatus)';
}
