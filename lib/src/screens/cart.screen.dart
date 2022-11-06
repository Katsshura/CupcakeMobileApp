import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/events/cart/cart.event.dart';
import 'package:cupcake/src/data/providers/cart/cart.provider.dart';
import 'package:cupcake/src/enums/cart_actions.enum.dart';
import 'package:cupcake/src/screens/empty_cart.screen.dart';
import 'package:cupcake/src/utils/image_loading.util.dart';
import 'package:cupcake/src/widgets/custom_app_bar.widget.dart';
import 'package:cupcake/src/widgets/custom_bottom_navigation_bar.widget.dart';
import 'package:cupcake/src/widgets/text_divider.widget.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = CartProvider.ofCart(context);

    return Scaffold(
      appBar: CustomAppBar.build(context, TextConstants.cartAppBarTitle),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return EmptyCartScreen();
            }

            final map = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20, left: 30),
                ),
                TextDivider(text: '${map.length} items'),
                Container(
                  height: MediaQuery.of(context).size.height / 1.80,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ListView.builder(
                    itemCount: map.length,
                    itemBuilder: (context, index) {
                      final key = map.keys.elementAt(index);

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
                                    map[key]!.product.imageUrl,
                                    loadingBuilder:
                                        ImageLoadingUtil.getLoadingProgress,
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
                                      map[key]!.product.name,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Container(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 70,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Text(
                                        map[key]!.product.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'R\$ ${map[key]!.product.price * Decimal.parse(map[key]!.quantity.toString())}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            child:
                                                const Icon(Icons.add, size: 16),
                                            onTap: () => bloc.publish(CartEvent(
                                                CartAction.increase, key)),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child:
                                                Text('${map[key]!.quantity}'),
                                          ),
                                          InkWell(
                                            child: const Icon(
                                              Icons.remove,
                                              size: 16,
                                            ),
                                            onTap: () => bloc.publish(CartEvent(
                                                CartAction.decrease, key)),
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
                                            color:
                                                Color.fromRGBO(21, 84, 246, 1),
                                          ),
                                        ),
                                        onTap: () => bloc.publish(
                                            CartEvent(CartAction.delete, key)),
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
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(TextConstants.cartTotalLabel,
                                style: Theme.of(context).textTheme.headline5),
                            Text(
                              'R\$ ${map.values.map((value) => value.product.price * Decimal.parse(value.quantity.toString())).reduce((value, element) => value + element) + Decimal.parse('4.99')}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          TextConstants.cartWarningLabel,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: () =>
                                Navigator.popUntil(context, (route) => route.isFirst),
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(5.0),
                                backgroundColor: MaterialStateColor.resolveWith(
                                        (states) => Theme.of(context).primaryColor),
                                textStyle: MaterialStateProperty.resolveWith(
                                        (states) => Theme.of(context).textTheme.button)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(TextConstants.goToPaymentButton),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
