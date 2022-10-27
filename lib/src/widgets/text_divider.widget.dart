import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;

  const TextDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildDivider(),
        Text(text, style: Theme.of(context).textTheme.overline),
        _buildDivider()
      ],
    );
  }

  Widget _buildDivider() {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: const Divider(
        height: 36,
      ),
    ));
  }
}
