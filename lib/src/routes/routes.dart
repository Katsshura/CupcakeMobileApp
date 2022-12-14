import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/data/events/login.event.dart';
import 'package:cupcake/src/data/providers/address_registration_screen.provider.dart';
import 'package:cupcake/src/data/providers/home/home_screen.provider.dart';
import 'package:cupcake/src/data/providers/login_screen.provider.dart';
import 'package:cupcake/src/data/providers/order/order.provider.dart';
import 'package:cupcake/src/data/providers/order/order_details.provider.dart';
import 'package:cupcake/src/data/providers/payment/payment.provider.dart';
import 'package:cupcake/src/data/providers/payment/payment_registration.provider.dart';
import 'package:cupcake/src/data/providers/registration_screen.provider.dart';
import 'package:cupcake/src/data/providers/user.provider.dart';
import 'package:cupcake/src/models/product/product.model.dart';
import 'package:cupcake/src/models/user/registration/user_registration.model.dart';
import 'package:cupcake/src/screens/address_registration.screen.dart';
import 'package:cupcake/src/screens/cart.screen.dart';
import 'package:cupcake/src/screens/home.screen.dart';
import 'package:cupcake/src/screens/login.screen.dart';
import 'package:cupcake/src/screens/order.screen.dart';
import 'package:cupcake/src/screens/order_details.screen.dart';
import 'package:cupcake/src/screens/payment.screen.dart';
import 'package:cupcake/src/screens/payment_registration.screen.dart';
import 'package:cupcake/src/screens/product.screen.dart';
import 'package:cupcake/src/screens/registration.screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route build(RouteSettings settings) {
    switch (settings.name) {
      case RoutesPath.home:
        return _buildHomePage();
      case RoutesPath.login:
        final redirect = settings.arguments as String;
        return _buildLoginPage(redirect);
      case RoutesPath.registration:
        return _buildRegistrationPage();
      case RoutesPath.registrationAddress:
        final model = settings.arguments as UserRegistrationModel;
        return _buildAddressRegistrationPage(model);
      case RoutesPath.productDetails:
        final model = settings.arguments as ProductModel;
        return _buildProductDetailsPage(model);
      case RoutesPath.cart:
        return _buildCartPage();
      case RoutesPath.payment:
        return _buildPaymentPage();
      case RoutesPath.paymentRegister:
        final redirect = settings.arguments as String;
        return _buildPaymentRegistrationPage(redirect);
      case RoutesPath.order:
        return _buildOrderPage();
      case RoutesPath.orderDetails:
        final orderId = settings.arguments as int;
        return _buildOrderDetailsPage(orderId);
      default:
        return _buildNotFoundPage();
    }
  }

  static _buildNotFoundPage() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Text('Not Found!'),
          ),
        );
      },
    );
  }

  static _buildHomePage() {
    return MaterialPageRoute(
      builder: (context) {
        return HomeScreenProvider(
          child: HomeScreen(),
        );
      },
    );
  }

  static _buildLoginPage(String redirect) {
    return MaterialPageRoute(
      builder: (context) {
        return StreamBuilder<UserTokenEvent>(
            stream: UserProvider.ofUser(context).stream,
            builder: (context, snapshot) {
              return LoginScreenProvider(
                  child: LoginScreen(
                redirectPath: redirect,
              ));
            });
      },
    );
  }

  static _buildRegistrationPage() {
    return MaterialPageRoute(builder: (context) {
      return RegistrationScreenProvider(
        child: RegistrationScreen(),
      );
    });
  }

  static _buildAddressRegistrationPage(UserRegistrationModel model) {
    return MaterialPageRoute(
      builder: (context) {
        return AddressRegistrationScreenProvider(
            child: AddressRegistrationScreen(
          registrationModel: model,
        ));
      },
    );
  }

  static _buildProductDetailsPage(ProductModel model) {
    return MaterialPageRoute(
      builder: (context) {
        return ProductScreen(
          model: model,
        );
      },
    );
  }

  static _buildCartPage() {
    return MaterialPageRoute(
      builder: (context) => CartScreen(),
    );
  }

  static _buildPaymentPage() {
    return MaterialPageRoute(
      builder: (context) => PaymentProvider(child: const PaymentScreen()),
    );
  }

  static _buildPaymentRegistrationPage(String redirect) {
    return MaterialPageRoute(
      builder: (context) {
        return PaymentRegistrationProvider(
            child: PaymentRegistrationScreen(
          redirectPath: redirect,
        ));
      },
    );
  }

  static _buildOrderPage() {
    return MaterialPageRoute(
      builder: (context) => OrderProvider(child: OrderScreen()),
    );
  }

  static _buildOrderDetailsPage(int orderId) {
    return MaterialPageRoute(
      builder: (context) => OrderDetailsProvider(
          child: OrderDetailsScreen(
        orderId: orderId,
      )),
    );
  }
}
