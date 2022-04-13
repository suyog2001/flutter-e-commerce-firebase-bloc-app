part of 'app_bloc.dart';

/// AppStatus of Two type
///
/// + authenticated
/// + unauthenticated
enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  /// For authenticated State with user property
  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  /// For unauthenticated State
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
