import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/providers/order/order.provider.dart';
import 'package:cupcake/src/widgets/custom_app_bar.widget.dart';
import 'package:cupcake/src/widgets/custom_bottom_navigation_bar.widget.dart';
import 'package:cupcake/src/widgets/order/order_item_tile.widget.dart';
import 'package:cupcake/src/widgets/text_divider.widget.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderBloc = OrderProvider.ofOrder(context);
    OrderProvider.fetchUserOrders(context);

    return Scaffold(
      appBar: CustomAppBar.build(context, TextConstants.ordersAppBarTitle),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: StreamBuilder(
        stream: orderBloc.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return FutureBuilder(
            future: snapshot.data!,
            builder: (context, listSnapshot) {
              if (!listSnapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container(
                margin:
                    const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                child: Column(
                  children: [
                    TextDivider(text: '${listSnapshot.data!.length} Pedidos'),
                    Expanded(
                      child: ListView.builder(
                        itemCount: listSnapshot.data!.length,
                        itemBuilder: (context, index) {
                          final item = listSnapshot.data![index];

                          final List<Widget> orderItems = item.orderItems
                              .map((e) => OrderItemTile(model: e,))
                              .cast<Widget>()
                              .toList();

                          orderItems.add(
                            Container(
                              margin: const EdgeInsets.only(left: 16, right: 16, top: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total: ',
                                        style: Theme.of(context).textTheme.headline5,
                                      ),
                                      Text(
                                        'R\$ ${item.orderTotal}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto',
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(height: 15,)
                                ],
                              ),
                            )
                          );

                          return Card(
                            color: Colors.white.withOpacity(0.92),
                            child: InkWell(
                              onTap: () => print(item.orderId),
                              child: Column(
                                children: orderItems,
                              ),
                            ),
                          );
                        },
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
}
