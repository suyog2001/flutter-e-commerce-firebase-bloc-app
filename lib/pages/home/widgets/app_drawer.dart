import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_bloc/app_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Drawer(
      child: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                  radius: 40,
                  child: user.photo == null
                      ? Text(user.email![0].toUpperCase())
                      : null,
                  backgroundImage:
                      user.photo != null ? NetworkImage(user.photo!) : null),
              title: Text(
                user.email ?? '',
              ),
            ),
          ),
          const Divider()
        ]),
      ),
    );
  }
}
