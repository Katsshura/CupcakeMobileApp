import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/providers/cart/cart.provider.dart';
import 'package:cupcake/src/data/providers/payment/payment.provider.dart';
import 'package:cupcake/src/widgets/cart/cart_totals.widget.dart';
import 'package:cupcake/src/widgets/custom_app_bar.widget.dart';
import 'package:cupcake/src/widgets/custom_bottom_navigation_bar.widget.dart';
import 'package:cupcake/src/widgets/payment/new_payment.widget.dart';
import 'package:cupcake/src/widgets/payment/payment_type.widget.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalBloc = CartProvider.ofTotal(context);
    final paymentBloc = PaymentProvider.ofPayment(context);

    return Scaffold(
      appBar: CustomAppBar.build(context, TextConstants.paymentAppBarTitle),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: StreamBuilder(
        stream: totalBloc.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 30.0, top: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      TextConstants.paymentWalletLabel,
                      style: TextStyle(
                          fontFamily: 'Neuton',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                          fontSize: 15,
                          color: Color.fromRGBO(0, 0, 0, 0.7)),
                    ),
                    Container(
                      height: 10,
                    ),
                    const Text(
                      TextConstants.paymentAvailableMoney,
                      style: TextStyle(
                          fontFamily: 'Neuton',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                          fontSize: 12,
                          color: Color.fromRGBO(0, 0, 0, 0.7)),
                    ),
                    Container(
                      height: 10,
                    ),
                    const Text(
                      'R\$: 0,00',
                      style: TextStyle(
                          fontFamily: 'Neuton',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                          fontSize: 12,
                          color: Color.fromRGBO(129, 127, 127, 0.76)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 30,
                  top: 50,
                ),
                child: Text(
                  TextConstants.paymentMethodsLabel,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30),
                height: MediaQuery.of(context).size.height / 5,
                child: StreamBuilder(
                  stream: paymentBloc.stream,
                  builder: (context, selectedSnapshot) {
                    return FutureBuilder(
                      future: PaymentProvider.getPaymentMethods(context),
                      builder: (context, paymentsSnapshot) {
                        if (!paymentsSnapshot.hasData) {
                          return Container(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: const Center(
                                  child: CircularProgressIndicator()));
                        }

                        final data = paymentsSnapshot.data!;

                        if (data.isEmpty) {
                          return const NewPaymentWidget();
                        }

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];

                            if (index == 0) {
                              return Row(
                                children: [
                                  const NewPaymentWidget(),
                                  Container(
                                    width: 10,
                                  ),
                                  PaymentTypeWidget(
                                    selected: selectedSnapshot.hasData
                                        ? selectedSnapshot.data!
                                        : 0,
                                    paymentModel: item,
                                    onPressed: () =>
                                        paymentBloc.publish(item.id!),
                                  )
                                ],
                              );
                            }

                            return Row(
                              children: [
                                PaymentTypeWidget(
                                  selected: selectedSnapshot.hasData
                                      ? selectedSnapshot.data!
                                      : 0,
                                  paymentModel: item,
                                  onPressed: () =>
                                      paymentBloc.publish(item.id!),
                                ),
                                Container(
                                  width: 10,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 5,
              ),
              CartTotals(
                totalValue: snapshot.data!,
                onPressed: () => PaymentProvider.createOrder(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
