import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/providers/cart/cart.provider.dart';
import 'package:cupcake/src/data/providers/user.provider.dart';
import 'package:cupcake/src/routes/routes.dart';
import 'package:cupcake/src/themes/main.theme.dart';
import 'package:flutter/material.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UserProvider(
      child: CartProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.build,
          theme: AppTheme.buildLightPrimary(),
          title: TextConstants.appName,
        ),
      ),
    );
  }

}