import 'package:carousel_slider/carousel_slider.dart';
import 'package:cupcake/src/data/blocs/home/highlight.bloc.dart';
import 'package:cupcake/src/models/product/highlight/highlight.model.dart';
import 'package:cupcake/src/widgets/highlight.widget.dart';
import 'package:cupcake/src/widgets/loading/highlight_loading.widget.dart';
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
        }
    );
  }
}