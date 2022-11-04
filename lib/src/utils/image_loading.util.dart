import 'package:flutter/material.dart';

class ImageLoadingUtil {
  static Widget getLoadingProgress(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) return child;

    return Center(
      child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null),
    );
  }
}
