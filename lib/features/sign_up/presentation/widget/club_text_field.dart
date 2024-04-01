import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/sign_up/presentation/bloc/sign_up_cubit.dart';

import '../../form_fields/club_name.dart';

class ClubTextFiled extends StatefulWidget {
  const ClubTextFiled({
    Key? key,
  }) : super(key: key);

  @override
  State<ClubTextFiled> createState() => _ClubTextFiledState();
}

class _ClubTextFiledState extends State<ClubTextFiled> {
  final _clubNameFocusNode = FocusNode();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _clubNameFocusNode.addListener(() {
      if (!_clubNameFocusNode.hasFocus) {
        final cubit = context.read<SignUpCubit>();
        cubit.onClubUnFocused();
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
        final clubNameError =
            state.clubName.isNotValid ? state.clubName.error : null;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            focusNode: _clubNameFocusNode,
            controller: _controller,
            onChanged: cubit.onClubNameChanged,
            style: AT.t.body1.theme,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: brandColorTextFieldBoard,
            decoration: textFieldInputDecoration(
              onClear: () {
                _controller.clear();
              },
              labelText: 'Название клуба',
              hintText: 'Спартарсе',
              suffixIcon: Icon(
                Icons.group,
                color: brandColorTextFieldBoard,
              ),
              enabled: !isSubmissionInProgress,
              errorText: clubNameError == null
                  ? null
                  :clubNameError == ClubNameValidationError.empty
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
    _clubNameFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
