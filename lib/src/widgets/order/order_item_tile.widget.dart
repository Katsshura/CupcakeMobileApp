import 'package:cupcake/src/models/order/response/order_item.model.dart';
import 'package:flutter/material.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItemModel model;

  const OrderItemTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: ListTile(
            leading: Text(
              model.product.name,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0))
                  ),
                  child: Center(
                    child: Text(
                      '${model.quantity}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Container(
                  height: 5,
                )
              ],
            ),
            trailing: Text(
              'R\$ ${model.total}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ],
    );
  }

}