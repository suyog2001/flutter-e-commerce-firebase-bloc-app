import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/app/views/my_app_view.dart';
import '../app_bloc/app_bloc.dart';

import '../../routes/app_route.dart';

class MyApp extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;

  final AppRoute _route;
  const MyApp(
      {Key? key,
      required AuthenticationRepository authenticationRepository,
      required AppRoute appRoute})
      : _authenticationRepository = authenticationRepository,
        _route = appRoute,
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
      ],
      child: BlocProvider(
          create: (context) =>
              AppBloc(authenticationRepository: _authenticationRepository),
          child: MyAppView(appRoute: _route)),
    );
  }
}
