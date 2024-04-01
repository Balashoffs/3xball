import 'package:flutter/material.dart';
class ExtendedScaffoldWidget extends StatelessWidget {
  const ExtendedScaffoldWidget({super.key, required this.child, this.canPop = true});

  final Widget child;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: PopScope(canPop :canPop, child: child),
      ),
    );
  }
}

