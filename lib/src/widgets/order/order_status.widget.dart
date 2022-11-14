import 'package:cupcake/src/models/order/response/order_status.model.dart';
import 'package:flutter/material.dart';

class OrderStatusWidget extends StatelessWidget {
  final OrderStatusModel model;

  const OrderStatusWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline_outlined),
          Container(
            width: 10,
          ),
          Text(
            _convertStatusToPortuguese(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto'
            ),
          )
        ],
      ),
    );
  }

  String _convertStatusToPortuguese() {
    switch (model.status) {
      case 'CREATED':
        return 'Pedido Criado';
      case 'ACCEPTED':
        return 'Pedido Aceite';
      case 'REJECTED':
        return 'Pedido Rejeitado';
      case 'CANCELED':
        return 'Pedido Cancelado';
      case 'IN_PREPARATION':
        return 'Pedido em Preparação';
      case 'ROUTE_TO_DELIVERY':
        return 'Em rota de entrega';
      case 'DELIVERED':
        return 'Entregue';
      case 'FINISHED':
        return 'Finalizado';
    }
    return '';
  }
}
