import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/blocs/cart/cart.bloc.dart';
import 'package:cupcake/src/data/events/cart/cart.event.dart';
import 'package:cupcake/src/enums/cart_actions.enum.dart';
import 'package:cupcake/src/models/cart/cart.model.dart';
import 'package:cupcake/src/utils/image_loading.util.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final CartModel cartModel;
  final int productId;
  final CartBloc bloc;

  const CartItem({
    super.key,
    required this.cartModel,
    required this.productId,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 96,
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 96,
                width: 96,
                child: Image.network(
                  cartModel.product.imageUrl,
                  loadingBuilder: ImageLoadingUtil.getLoadingProgress,
                ),
              ),
              Container(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartModel.product.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Container(
                    height: 5,
                  ),
                  SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      cartModel.product.description,
                      style: Theme.of(context).textTheme.subtitle2,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'R\$ ${cartModel.product.price * Decimal.parse(cartModel.quantity.toString())}',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: const Icon(Icons.add, size: 16),
                          onTap: () => bloc.publish(
                              CartEvent(CartAction.increase, productId)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Text('${cartModel.quantity}'),
                        ),
                        InkWell(
                          child: const Icon(
                            Icons.remove,
                            size: 16,
                          ),
                          onTap: () => bloc.publish(
                              CartEvent(CartAction.decrease, productId)),
                        ),
                      ],
                    ),
                    InkWell(
                      child: const Text(
                        TextConstants.cartRemoveButton,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(21, 84, 246, 1),
                        ),
                      ),
                      onTap: () =>
                          bloc.publish(CartEvent(CartAction.delete, productId)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
