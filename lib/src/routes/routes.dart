import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/data/events/login.event.dart';
import 'package:cupcake/src/data/providers/login_screen.provider.dart';
import 'package:cupcake/src/data/providers/registration_screen.provider.dart';
import 'package:cupcake/src/data/providers/user.provider.dart';
import 'package:cupcake/src/screens/login.screen.dart';
import 'package:cupcake/src/screens/registration.screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route build(RouteSettings settings) {
    switch (settings.name) {
      case RoutesPath.home:
        return _buildLoginPage();
      case RoutesPath.login:
        return _buildLoginPage();
      case RoutesPath.registration:
        return _buildRegistrationPage();
      default:
        return _buildNotFoundPage();
    }
  }

  static _buildNotFoundPage() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Text('Not Found!'),
          ),
        );
      },
    );
  }

  static _buildLoginPage() {
    return MaterialPageRoute(
      builder: (context) {
        return StreamBuilder<UserTokenEvent>(
            stream: UserProvider.ofUser(context).stream,
            builder: (context, snapshot) {
              return LoginScreenProvider(
                  child: const LoginScreen(
                redirectPath: '/2',
              ));
            });
      },
    );
  }

  static _buildRegistrationPage() {
    return MaterialPageRoute(builder: (context) {
      return RegistrationScreenProvider(
        child: RegistrationScreen(),
      );
    });
  }
}
