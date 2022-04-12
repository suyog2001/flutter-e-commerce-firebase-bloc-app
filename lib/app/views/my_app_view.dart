import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/app/app_bloc/app_bloc.dart';
import 'package:flutter_e_commerce_app/routes/app_route.dart';

class MyAppView extends StatelessWidget {
  MyAppView({Key? key, required AppRoute appRoute})
      : _appRoute = appRoute,
        super(key: key);
  final AppRoute _appRoute;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // onGenerateRoute: _appRoute.onGenerateRoute,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
