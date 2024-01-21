import 'package:flutter/material.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerLoadingWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300], // Set the base color
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
