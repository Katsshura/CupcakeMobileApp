import 'package:cupcake/src/data/events/login.event.dart';
import 'package:cupcake/src/data/providers/login_screen.provider.dart';
import 'package:cupcake/src/data/providers/user.provider.dart';
import 'package:cupcake/src/screens/login.screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route build(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildLoginPage();
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
            return LoginScreenProvider(child: LoginScreen(redirectPath: '/2',));
          }
        );
      },
    );
  }
}