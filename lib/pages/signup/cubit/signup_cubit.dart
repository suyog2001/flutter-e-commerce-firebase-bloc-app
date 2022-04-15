import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_e_commerce_app/data/repositories/firestore_repository.dart';

import '../../../app/user_type_cubit/user_type_cubit.dart';
import '../../../constant/form_status.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthenticationRepository _authRepository;
  final FireStoreRepository _fireStoreRepository;
  final UserTypeCubit _userTypeCubit;
  late final StreamSubscription _subscription;
  UserType _userType = UserType.none;
  SignupCubit(
      {required AuthenticationRepository authenticationRepository,
      required FireStoreRepository fireStoreRepository,
      required UserTypeCubit userTypeCubit})
      : _authRepository = authenticationRepository,
        _userTypeCubit = userTypeCubit,
        _fireStoreRepository = fireStoreRepository,
        super(const SignupState()) {
    _subscription = _userTypeCubit.stream.listen((userTypeState) {
      _userType = userTypeState;
      print(_userType);
    });
  }
  @override
  Future<void> close() async {
    _subscription.cancel;
    return super.close();
  }

  /// Chech email on every event user enters and change state accordingly
  void emailChanged(String value) {
    emit(
      state.copyWith(email: value, formStatus: const InitialFormStatus()),
    );
  }

  /// Chech password on every event user enters and change state accordingly
  void passwordChanged(String password) {
    emit(
      state.copyWith(password: password, formStatus: const InitialFormStatus()),
    );
  }

  /// Validate the form before using this funciton.
  /// Initates the login Login process
  Future<void> onSignupSubmit() async {
    if (state.formStatus is FormSubmmitingStatus) return;
    emit(state.copyWith(formStatus: FormSubmmitingStatus()));
    try {
      if (_userType == UserType.none) {
        throw Exception('Select User type');
      }
      await _authRepository.signUp(
          email: state.email, password: state.password);
      _fireStoreRepository.storeUserByType(
          _userType.name, _authRepository.currentUser.id);
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
