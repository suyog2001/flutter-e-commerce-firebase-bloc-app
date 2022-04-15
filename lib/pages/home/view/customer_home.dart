import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_bloc/app_bloc.dart';
import '../widgets/app_drawer.dart';

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: CustomerHomePage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Home'),
        centerTitle: true,
        actions: [
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.filter_alt_rounded),
                  label: const Text('Filter'),
                  onPressed: () {
                    showFilterModelBottomSheet(context);
                  },
                ),
              )
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(itemBuilder: ((context, index) {
              return Container(
                height: 50,
                child: Text('index $index'),
              );
            })),
          )
        ],
      ),
    );
  }

  void showFilterModelBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  const Text(
                    'Filter Products',
                    style: TextStyle(fontSize: 30),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView(
                      children: [],
                    ),
                  ),
                ],
              ),
            ));
  }
}
