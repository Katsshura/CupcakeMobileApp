import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/models/product/product.model.dart';
import 'package:cupcake/src/utils/image_loading.util.dart';
import 'package:cupcake/src/widgets/custom_app_bar.widget.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel model;

  const ProductScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(context, model.name),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Image.network(
                model.imageUrl,
                loadingBuilder: ImageLoadingUtil.getLoadingProgress,
              ),
            ),
            Container(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    model.name,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      color: Colors.black.withOpacity(0.75),
                      letterSpacing: 1.0
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    'R\$ ${model.price}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        color: Colors.black.withOpacity(0.9),
                        letterSpacing: 1.0
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              padding: const EdgeInsets.all(20.0),
              child: Text(
                model.description,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: ElevatedButton(
                onPressed: () => print('pressed'),
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5.0),
                    backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).primaryColor),
                    textStyle: MaterialStateProperty.resolveWith(
                            (states) => Theme.of(context).textTheme.button)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(TextConstants.productDetailsAddToCartText),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
