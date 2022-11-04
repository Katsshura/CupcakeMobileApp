import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/models/product/product.model.dart';
import 'package:flutter/material.dart';

class ProductCarousel extends StatelessWidget {
  final List<ProductModel> list;

  const ProductCarousel({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = list[index];
          return Row(
            children: [
              InkWell(
                onTap: () => Navigator.pushNamed(
                    context, RoutesPath.productDetails,
                    arguments: item,
                ),
                child: SizedBox(
                  width: 128,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 128,
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(item.imageUrl),
                          ),
                        ),
                      ),
                      Text(
                        item.name,
                        style: Theme.of(context).textTheme.headline5,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Container(
                        height: 3,
                      ),
                      Text(
                        item.description,
                        style: Theme.of(context).textTheme.subtitle2,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                const Color.fromRGBO(18, 18, 18, 0.03),
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 10,
              )
            ],
          );
        },
      ),
    );
  }
}
