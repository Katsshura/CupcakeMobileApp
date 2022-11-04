import 'package:carousel_slider/carousel_slider.dart';
import 'package:cupcake/src/data/blocs/home/highlight.bloc.dart';
import 'package:cupcake/src/data/blocs/home/product.bloc.dart';
import 'package:cupcake/src/models/product/highlight/highlight.model.dart';
import 'package:cupcake/src/widgets/highlight.widget.dart';
import 'package:cupcake/src/widgets/loading/highlight_loading.widget.dart';
import 'package:cupcake/src/widgets/product_carousel.widget.dart';
import 'package:flutter/material.dart';

class HomeScreenBuilder {
  Widget buildHighlightWidget(HighlightBloc bloc) {
    return StreamBuilder<Future<HighlightModel>>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: HighlightLoadingWidget(),
            );
          }

          return FutureBuilder(
            future: snapshot.data!,
            builder: (context, content) {
              if (!content.hasData) {
                return const HighlightLoadingWidget();
              }

              return HighlightWidget(model: content.data!);
            },
          );
        });
  }

  Widget buildProductHorizontalList(ProductBloc bloc) {
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return FutureBuilder(
          future: snapshot.data,
          builder: (context, listItem) {
            if (!listItem.hasData) {
              return const CircularProgressIndicator();
            }

            return ProductCarousel(list: listItem.data!);
          },
        );
      },
    );
  }
}
