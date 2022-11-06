import 'package:cupcake/src/consts/env.const.dart';
import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/utils/image_loading.util.dart';
import 'package:flutter/material.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 180,
          width: 226,
          child: Image.network(
            Env.emptyLogoUrl,
            loadingBuilder: ImageLoadingUtil.getLoadingProgress,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20.0, top: 30),
          padding: const EdgeInsets.only(left: 60.0, right: 60.0),
          child: Text(
            TextConstants.emptyCartText,
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.only(left: 50, right: 50),
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
                Text(TextConstants.emptyCartButton),
              ],
            ),
          ),
        )
      ],
    );
  }
}
