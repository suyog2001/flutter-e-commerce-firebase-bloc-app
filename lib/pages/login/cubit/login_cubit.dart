import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../constant/form_status.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authRepository;
  LoginCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authRepository = authenticationRepository,
        super(const LoginState());

  /// Checks email on every event user enters and change state accordingly
  void emailChanged(String value) {
    emit(
      state.copyWith(email: value, formStatus: const InitialFormStatus()),
    );
  }

  /// Checks password on every event user enters and change state accordingly
  void passwordChanged(String password) {
    emit(
      state.copyWith(password: password, formStatus: const InitialFormStatus()),
    );
  }

  /// Validate the form before using this funciton.
  /// Initates the login Login process
  void onLoginSubmit() {
    if (state.formStatus is FormSubmmitingStatus) return;
    emit(state.copyWith(formStatus: FormSubmmitingStatus()));
    try {
      _authRepository.logInWithEmailAndPassword(
          email: state.email, password: state.password);

      emit(state.copyWith(formStatus: FormSubmmisionSuccessStatus()));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
          formStatus: FormSubmissionFailedStatus(errorMessage: e.message)));
    } catch (er) {
      emit(state.copyWith(
          formStatus: FormSubmissionFailedStatus(errorMessage: er.toString())));
    }
  }
}
