import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_e_commerce_app/utility/bloc_observer.dart';

import 'app/views/my_app.dart';
import 'routes/app_route.dart';

void main() async {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final authenticationRepository = AuthenticationRepository();
      await authenticationRepository.user.first;
      runApp(MyApp(
        authenticationRepository: authenticationRepository,
        appRoute: AppRoute(),
      ));
    },
    blocObserver: AppBlocObserver(),
  );
}
