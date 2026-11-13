import 'package:flutter/material.dart';

/// Memastikan layout tetap proporsional dan tidak meregang di tablet atau desktop/web.
class AdaptiveContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;

  const AdaptiveContainer({
    super.key,
    required this.child,
    this.maxWidth = 600.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
