import 'package:flutter/material.dart';
import 'package:three_x_ball/core/utils/colors.dart';
class ExtendedScaffoldWidget extends StatelessWidget {
  const ExtendedScaffoldWidget({super.key, required this.child, this.canPop = true});

  final Widget child;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: brandColorBaseBackground.withAlpha(100),
        body: PopScope(canPop :canPop, child: child),
      ),
    );
  }
}

