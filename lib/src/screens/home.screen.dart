import 'package:cupcake/src/builders/home/home_screen.builder.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/providers/home/home_screen.provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget with HomeScreenBuilder {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider.fetchHighlight(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
        ],
      ),
    );
  }
}
