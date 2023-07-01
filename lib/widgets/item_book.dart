import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rakuten_books_viewer/model/rakuten_api.dart';

// ignore: must_be_immutable
class ContainerBook extends StatelessWidget {
  late RakutenBooksItem item;
  double width;
  late double height;
  late double paddingWidth;
  late double paddingHeight;

  ContainerBook({super.key, required this.item, this.width = 100}) {
    height = width * sqrt(2);
    paddingWidth = width * 0.1;
    paddingHeight = paddingWidth * 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingWidth),
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.network(
                    item.largeImageUrl,
                    fit: BoxFit.cover,
                    /*
                height: double.infinity,
                width: double.infinity,*/
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      /*
      child: Column(
        children: [
          Image.network(
            item.largeImageUrl,
            fit: BoxFit.fill,
          ),
        ],
      ),*/
    );
  }
}
