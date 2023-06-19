import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.width = 200,
    this.height = 500,
    this.radius = 15,
    this.color = Colors.deepPurpleAccent,
    this.child = const Text("Button"),
  }) : super(key: key);

  final double width;
  final double height;
  final double radius;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: child,
    );
  }
}
