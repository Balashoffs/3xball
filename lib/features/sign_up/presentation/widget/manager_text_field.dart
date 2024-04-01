import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';

import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/sign_up/presentation/bloc/sign_up_cubit.dart';

import '../../form_fields/user_fi.dart';

class ManagerTextField extends StatefulWidget {
  const ManagerTextField({Key? key}) : super(key: key);

  @override
  State<ManagerTextField> createState() => _ManagerTextFieldState();
}

class _ManagerTextFieldState extends State<ManagerTextField> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        final cubit = context.read<SignUpCubit>();
        cubit.onUserFIFocused();
      }
    });

    _controller.addListener(() {
      String controllerText = _controller.text.trim();
      bool isChange = isChangeFirstLetter(controllerText);
      if (isChange) {
        String value = controllerText;
        String last = value[value.length - 1].toUpperCase();
        String newValue =
            value.replaceRange(value.length - 1, value.length, last);
        _controller.value = TextEditingValue(
          text: newValue,
          selection: TextSelection.fromPosition(
            TextPosition(offset: controllerText.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();
        final isSubmissionInProgress =
            state.submissionStatus == SubmissionStatus.inProgress;
        final userFIError = state.userFI.isNotValid ? state.userFI.error : null;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            focusNode: _focusNode,
            controller: _controller,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            onChanged: cubit.onUserFIChanged,
            autocorrect: false,
            style: AT.t.body1.theme,
            cursorColor: brandColorTextFieldBoard,
            decoration: textFieldInputDecoration(
              onClear: () {
                _controller.clear();
              },
              labelText: 'Имя, Фамилия менеджера',
              enabled: !isSubmissionInProgress,
              hintText: 'Иван Поляков',
              suffixIcon: Icon(
                Icons.person,
                color: brandColorTextFieldBoard,
              ),
              errorText: userFIError == null
                  ? null
                  : userFIError == UserFIValidationError.empty
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
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
