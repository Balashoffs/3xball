import 'package:flutter/material.dart';

import 'package:three_x_ball/core/utils/utils.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: textFieldTextStyle(16),
        cursorColor: brandColorTextFieldBoard,
        decoration: textFieldInputDecoration(
          onClear: () {},
          labelText: 'Эл. почта',
          hintText: 'example@.com',
          suffixIcon: Icon(Icons.alternate_email, color: brandColorTextFieldBoard),
          enabled: false,
        ),
      ),
    );
  }
}
