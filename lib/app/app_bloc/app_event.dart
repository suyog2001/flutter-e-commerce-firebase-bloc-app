part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

/// Logout Event : When Logout (Button) event is called.
class AppLogoutRequested extends AppEvent {}

/// AppUserState Event : Change state according to the user authenticated or not and informes the bloc to chage state
class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
