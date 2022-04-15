import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/app/user_type_cubit/user_type_cubit.dart';
import 'package:flutter_e_commerce_app/data/repositories/firestore_repository.dart';
import 'my_app_view.dart';
import '../app_bloc/app_bloc.dart';

class MyApp extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;
  final FireStoreRepository _fireStoreRepository;

  const MyApp({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required FireStoreRepository fireStoreRepository,
  })  : _authenticationRepository = authenticationRepository,
        _fireStoreRepository = fireStoreRepository,
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _fireStoreRepository)
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
            create: (_) =>
                AppBloc(authenticationRepository: _authenticationRepository)),
        BlocProvider(create: (_) => UserTypeCubit())
      ], child: MyAppView()),
    );
  }
}
