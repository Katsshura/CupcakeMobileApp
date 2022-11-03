import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/models/product/highlight/highlight.model.dart';
import 'package:flutter/material.dart';

class HighlightWidget extends StatelessWidget {
  final HighlightModel model;

  const HighlightWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RoutesPath.productDetails,
          arguments: model.product.id),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2.3,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(
                      MediaQuery.of(context).size.width, 75.0),
                  bottomRight: Radius.elliptical(
                      MediaQuery.of(context).size.width, 75.0),
                ),
                image: DecorationImage(
                  alignment: const FractionalOffset(0.5, 0.35),
                  fit: BoxFit.cover,
                  image: NetworkImage(model.product.imageUrl),
                  colorFilter: const ColorFilter.mode(
                      Color.fromRGBO(21, 84, 246, 0.3), BlendMode.saturation),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color.fromRGBO(18, 18, 18, 0.40),
                    Colors.white.withOpacity(0.0),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 50,
                ),
                Text(
                  model.title,
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    model.subtitle,
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
