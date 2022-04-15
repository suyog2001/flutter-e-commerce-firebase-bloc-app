import 'package:flutter/material.dart';

import '../app/app_bloc/app_bloc.dart';
import '../app/user_type_cubit/user_type_cubit.dart';
import '../pages/home/view/customer_home.dart';
import '../pages/home/view/home.dart';
import '../pages/home/view/seller_home.dart';
import '../pages/login/login.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [
        LoginPage.page(),
      ];
  }
}

List<Page> onGenerateHomeViewPages(UserType state, List<Page<dynamic>> pages) {
  switch (state) {
    case UserType.customer:
      return [CustomerHomePage.page()];
    case UserType.seller:
      return [
        SellerHomePage.page(),
      ];
    case UserType.none:
      // Handle this case
      return [
        const MaterialPage<void>(
            child: Scaffold(
          body: Center(
            child: Text('Error User is none'),
          ),
        ))
      ];
  }
}
