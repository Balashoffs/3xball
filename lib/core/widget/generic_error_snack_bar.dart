
import 'package:flutter/material.dart';

class GenericErrorSnackBar extends SnackBar {
  GenericErrorSnackBar({Key? key, required this.text})
      : super(
          key: key,
          content: _GenericErrorSnackBarMessage(text: text),
        );

  final String text;
}

class _GenericErrorSnackBarMessage extends StatelessWidget {
  const _GenericErrorSnackBarMessage({Key? key, required this.text})
      : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    // final l10n = ComponentLibraryLocalizations.of(context);
    return Text(
      text,
    );
  }
}
