import 'package:bloc/bloc.dart';

class AppBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print(change);
  }

  @override
  void onClose(BlocBase bloc) {
    print(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    print(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
  }
}
