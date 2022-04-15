import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/pages/product_add_page/view/product_add_page.dart';

import '../../../app/app_bloc/app_bloc.dart';
import '../../../app/user_type_cubit/user_type_cubit.dart';
import '../widgets/app_drawer.dart';

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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ProductAddPage()));
          },
          child: const Icon(Icons.add)),
      drawer: AppDrawer(),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
                child: user.photo == null ? Text(user.email![0]) : null,
                backgroundImage:
                    user.photo != null ? NetworkImage(user.photo!) : null),
            const SizedBox(height: 4),
            Text(
              user.email ?? '',
            ),
            BlocBuilder<UserTypeCubit, UserType>(
              builder: (context, state) {
                return Text(state.name);
              },
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
