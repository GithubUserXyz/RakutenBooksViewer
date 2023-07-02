import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rakuten_books_viewer/model/rakuten_api.dart';

// 画像をぼかすかどうか(trueでぼかし)
const _filterd = true;
// ImageFilterで使用される
const _sigmaX = 10.0;
const _sigmaY = 10.0;

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
                  child: drawImage(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawImage(BuildContext context) {
    // _filterdがtrueの場合はImageを子要素として持つImageFilterdを返し
    // falseの場合はImageをそのままかえす
    return _filterd
        ? ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: _sigmaX,
              sigmaY: _sigmaY,
            ),
            child: Image.network(
              item.largeImageUrl,
              fit: BoxFit.cover,
            ),
          )
        : Image.network(
            item.largeImageUrl,
            fit: BoxFit.cover,
          );
  }
}
