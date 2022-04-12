import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_bloc/app_bloc.dart';

class HomePage extends StatelessWidget {
  static const String route = '/';
  static Page page() => const MaterialPage<void>(child: HomePage());
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(backgroundImage: NetworkImage(user.photo ?? '')),
            const SizedBox(height: 4),
            Text(
              user.email ?? '',
            ),
            const SizedBox(height: 4),
            Text(
              user.name ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
