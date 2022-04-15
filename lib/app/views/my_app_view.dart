import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_bloc/app_bloc.dart';
import '../../routes/app_route.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ? FlowBuilder Takes care of the routing whent the AppBloc change it state
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
