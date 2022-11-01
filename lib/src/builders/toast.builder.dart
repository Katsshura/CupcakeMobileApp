import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastBuilder {

  static Widget buildErrorToast(String errorMessage) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error),
          SizedBox(
            width: 12.0,
          ),
          Flexible(child: Text(errorMessage)),
        ],
      ),
    );
  }

  static Widget buildSuccessToast(String successMessage) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Flexible(child: Text(successMessage)),
        ],
      ),
    );
  }

  static void showSuccessToast(BuildContext context, String successMessage) {
    final successToast =
    ToastBuilder.buildSuccessToast(successMessage);
    _showToast(successToast, context);
  }


  static void showErrorToast(BuildContext context, String errorMessage) {
    final errorToast =
    ToastBuilder.buildErrorToast(errorMessage);
    _showToast(errorToast, context);
  }

  static void _showToast(Widget toast, BuildContext context) {
    final fToast = FToast();
    fToast.init(context);
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 5),
    );
  }
}