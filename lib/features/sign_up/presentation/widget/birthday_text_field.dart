import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/sign_up/presentation/bloc/sign_up_cubit.dart';

import '../../form_fields/birthday.dart';

class BirthdayTextField extends StatefulWidget {
  const BirthdayTextField({Key? key}) : super(key: key);

  @override
  State<BirthdayTextField> createState() => _BirthdayTextFieldState();
}

class _BirthdayTextFieldState extends State<BirthdayTextField> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();
  int previous = 0;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        final cubit = context.read<SignUpCubit>();
        cubit.onBirthdayFocused();
      }
    });

    _controller.addListener(() {
      int currentPos = _controller.text.length;
      if (currentPos > previous) {
        bool isAdd = isAddDot(_controller.text);
        if (isAdd) {
          String newValue = '${_controller.text}.';
          _controller.value = TextEditingValue(
            text: newValue,
            selection: TextSelection.fromPosition(
              TextPosition(offset: newValue.length),
            ),
          );
        }
      }
      previous = currentPos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();
        final isSubmissionInProgress =
            state.submissionStatus == SubmissionStatus.inProgress;
        final birthdayError =
            state.birthday.isNotValid ? state.birthday.error : null;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            textInputAction: TextInputAction.next,
            autocorrect: false,
            controller: _controller,
            focusNode: _focusNode,
            onChanged: cubit.onBirthdayChanged,
            keyboardType: TextInputType.datetime,
            style: AT.t.body1.theme,
            cursorColor: brandColorTextFieldBoard,
            decoration: textFieldInputDecoration(
              onClear: () {
                _controller.clear();
              },
              suffixIcon: Icon(Icons.calendar_today_outlined,
                  color: brandColorTextFieldBoard),
              labelText: 'День рождения',
              hintText: '27.12.1982',
              enabled: !isSubmissionInProgress,
              errorText: birthdayError == null
                  ? null
                  : birthdayError == BirthdayValidationError.empty
                      ? 'Поле не должно быть пустым'
                      : 'Неверный набор символов',
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
