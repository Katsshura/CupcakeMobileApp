import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/events/cart/cart.event.dart';
import 'package:cupcake/src/data/providers/cart/cart.provider.dart';
import 'package:cupcake/src/enums/cart_actions.enum.dart';
import 'package:cupcake/src/screens/empty_cart.screen.dart';
import 'package:cupcake/src/utils/image_loading.util.dart';
import 'package:cupcake/src/widgets/cart/cart_item.widget.dart';
import 'package:cupcake/src/widgets/cart/cart_totals.widget.dart';
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
              return const EmptyCartScreen();
            }

            final map = snapshot.data!;
            final totalCart = map.values
                .map((value) =>
            value.product.price *
                Decimal.parse(value.quantity.toString()))
                .reduce((value, element) => value + element) +
                Decimal.parse('4.99');

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

                      return CartItem(
                        cartModel: map[key]!,
                        productId: key,
                        bloc: bloc,
                      );
                    },
                  ),
                ),
                CartTotals(
                  totalValue: totalCart,
                  onPressed: () {
                    CartProvider.ofTotal(context).publish(totalCart);
                    CartProvider.redirectToPaymentOrLogin(context);
                  },
                )
              ],
            );
          }),
    );
  }
}
