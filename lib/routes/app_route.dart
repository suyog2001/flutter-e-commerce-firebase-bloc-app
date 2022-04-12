import 'package:flutter/material.dart';

import '../app/app_bloc/app_bloc.dart';
import '../pages/home/view/home.dart';
import '../pages/login/login.dart';
import '../pages/signup/signup_page.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // Home Page route '/'
      case HomePage.route:
        return MaterialPageRoute(builder: (_) => HomePage());
      // Login Page route `/login`
      case LoginPage.route:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case SignupPage.route:
        return MaterialPageRoute(builder: (_) => SignupPage());
      default:
        // return null;
        // for return a error page
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Error Routing see into AppRoute'),
        ),
      );
    });
  }
}

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
