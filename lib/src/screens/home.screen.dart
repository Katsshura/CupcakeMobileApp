import 'package:cupcake/src/builders/home/home_screen.builder.dart';
import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/providers/home/home_screen.provider.dart';
import 'package:cupcake/src/widgets/custom_bottom_navigation_bar.widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget with HomeScreenBuilder {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider.fetchHighlight(context);
    HomeScreenProvider.fetchProducts(context, 0, '');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            InkWell(
              onLongPress: () => Navigator.pushNamed(context, RoutesPath.login,
                  arguments: RoutesPath.home),
              child: SizedBox(
                height: 36,
                width: 36,
                child: Image.asset("lib/resources/images/coffee_logo.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                'Av. Doutor Fulano, 0001',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, RoutesPath.cart),
            icon: const Icon(Icons.shopping_cart_checkout),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildHighlightWidget(HomeScreenProvider.ofHighlight(context)),
            Container(
              margin: const EdgeInsets.only(left: 20.0, top: 30.0),
              child: Text(
                TextConstants.homeScreenTitle,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, top: 8.0),
              child: Text(
                TextConstants.homeScreenSubtitle,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Container(
              height: 30,
            ),
            SizedBox(
              child: buildProductHorizontalList(
                  HomeScreenProvider.ofProduct(context)),
              height: 190,
            ),
          ],
        ),
      ),
    );
  }
}
