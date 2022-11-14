import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/providers/order/order_details.provider.dart';
import 'package:cupcake/src/widgets/custom_app_bar.widget.dart';
import 'package:cupcake/src/widgets/custom_bottom_navigation_bar.widget.dart';
import 'package:cupcake/src/widgets/order/order_item_tile.widget.dart';
import 'package:cupcake/src/widgets/order/order_status.widget.dart';
import 'package:cupcake/src/widgets/text_divider.widget.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final bloc = OrderDetailsProvider.ofOrderDetails(context);
    OrderDetailsProvider.fetchOrder(context, orderId);

    return Scaffold(
      appBar:
          CustomAppBar.build(context, TextConstants.orderDetailsAppBarTitle),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return FutureBuilder(
            future: snapshot.data!,
            builder: (context, orderSnapshot) {
              if (!orderSnapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final order = orderSnapshot.data!;

              final List<Widget> orderItems = order.orderItems
                  .map((e) => OrderItemTile(
                        model: e,
                      ))
                  .cast<Widget>()
                  .toList();

              orderItems.add(Container(
                height: 10,
              ));

              final List<Widget> orderStatus = order.orderStatus
                      .map((e) => OrderStatusWidget(model: e))
                      .cast<Widget>()
                      .toList();

              return Container(
                margin:
                    const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: orderItems,
                        ),
                      ),
                    ),
                    const TextDivider(text: TextConstants.orderStatusLabel),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: GestureDetector(
                        onTap: () => _underDevelopmentDialog(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              TextConstants.orderDetailsHelpButtonLabel,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(200, 56, 56, 1.0),
                              ),
                            ),
                            Container(
                              width: 5,
                            ),
                            const Icon(Icons.help_outline),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: orderStatus,
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 75,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(TextConstants.taxPaidLabel,
                                  style: Theme.of(context).textTheme.headline5),
                              Text(
                                'R\$ ${order.deliveryTax}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  fontFamily: 'Roboto',
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(TextConstants.cartTotalLabel,
                                  style: Theme.of(context).textTheme.headline5),
                              Text(
                                'R\$ ${order.orderTotal}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  fontFamily: 'Roboto',
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
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
}
