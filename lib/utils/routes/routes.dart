import 'package:flutter/material.dart';
import 'package:mvvm_provider_example/utils/routes/routes_name.dart';
import 'package:mvvm_provider_example/view/home_screen.dart';
import 'package:mvvm_provider_example/view/login_screen.dart';
import 'package:mvvm_provider_example/view/splash_screen.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch(settings.name) {

      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => SplashScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => LoginScreen());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => HomeScreen());

      default:
        return MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }

  }

}