import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/data/providers/user.provider.dart';
import 'package:cupcake/src/utils/jwt.util.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    const style = TextStyle(fontSize: 10, fontWeight: FontWeight.w700);
    return BottomNavigationBar(
      selectedItemColor: color,
      unselectedItemColor: color,
      unselectedLabelStyle: style,
      selectedLabelStyle: style,
      onTap: (value) => _navigateToPage(context, value),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Procurar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_rounded),
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.manage_accounts),
          label: 'Profile',
        ),
      ],
    );
  }

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.popUntil(context, (route) => route.isFirst);
        return;
      case 1:
        _underDevelopmentDialog(context);
        return;
      case 2:
        _redirectToOrdersOrLogin(context);
        return;
      case 3:
        // _underDevelopmentDialog(context);
        Navigator.pushNamed(context, RoutesPath.login,
            arguments: RoutesPath.home);
        return;
    }
  }

  void _underDevelopmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Feature em desenvolvimento!'),
        content: const Text(
            'Essa funcionalidade é apenas visual, será desenvolvida posteriormente.'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Entendido'))
        ],
      ),
    );
  }

  void _redirectToOrdersOrLogin(BuildContext context) {
    final token = UserProvider.ofUser(context).lastEmittedValue?.token;

    if (!JwtUtils.isValid(token)) {
      Navigator.pushNamed(context, RoutesPath.login,
          arguments: RoutesPath.order);
      return;
    }

    Navigator.pushNamed(context, RoutesPath.order);
  }
}
