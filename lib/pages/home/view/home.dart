import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/user_type_cubit/user_type_cubit.dart';

import '../../../routes/app_route.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());
  @override
  Widget build(BuildContext context) {
    return FlowBuilder<UserType>(
      state: context.select((UserTypeCubit bloc) => bloc.state),
      onGeneratePages: onGenerateHomeViewPages,
    );
  }
}
