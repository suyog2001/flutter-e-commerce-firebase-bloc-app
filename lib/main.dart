import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

import 'utility/bloc_observer.dart';

import 'app/views/my_app.dart';

void main() async {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      final authenticationRepository = AuthenticationRepository();
      await authenticationRepository.user.first;
      runApp(MyApp(
        authenticationRepository: authenticationRepository,
      ));
    },
    blocObserver: AppBlocObserver(),
  );
}
