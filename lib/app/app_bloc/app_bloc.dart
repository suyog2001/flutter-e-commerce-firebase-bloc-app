import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authenticationRepository.currentUser)
            : const AppState.unauthenticated()) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequest);
    _userSubscription = _authenticationRepository.user
        .listen((user) => add(AppUserChanged(user)));
  }
  final AuthenticationRepository _authenticationRepository;

  /// For subscription to the _AuthRepository user Stream
  late final StreamSubscription<User> _userSubscription;

  // For Logout
  void _onLogoutRequest(event, emit) {
    unawaited(_authenticationRepository.logOut());
  }

  // _onUserChanged changes state when the user is not Empty and emits authenticated or unauthenticated State accordingly
  void _onUserChanged(event, emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
