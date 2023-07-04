import 'package:flutter/material.dart';

class SlideShowWidget extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final double width;
  const SlideShowWidget({
    super.key,
    required this.items,
    required this.height,
    required this.width,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SlideShowState createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShowWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: PageView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return widget.items[index];
        },
      ),
    );
  }
}
