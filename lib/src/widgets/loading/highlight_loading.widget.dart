import 'package:flutter/material.dart';

class HighlightLoadingWidget extends StatelessWidget {
  const HighlightLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(
                    MediaQuery.of(context).size.width, 75.0),
                bottomRight: Radius.elliptical(
                    MediaQuery.of(context).size.width, 75.0),
              ),
            ),
          ),
          Column(
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          )
        ],
      ),
    );
  }

}