import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/edit_player/bloc/edit_player_cubit.dart';
import 'package:three_x_ball/features/edit_player/form_fields/user_fi.dart';

class PlayerFITextField extends StatefulWidget {
  const PlayerFITextField({Key? key, this.fullName}) : super(key: key);
  final String? fullName;

  @override
  State<PlayerFITextField> createState() => _PlayerFITextFieldState();
}

class _PlayerFITextFieldState extends State<PlayerFITextField> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        final cubit = context.read<EditPlayerCubit>();
        cubit.onUserFIFocused();
      }
    });
    if (widget.fullName != null) {
      _controller.text = widget.fullName!;
    }

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

    context.read<EditPlayerCubit>().onUserFIChanged(widget.fullName!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPlayerCubit, EditPlayerState>(
      builder: (context, state) {
        final cubit = context.read<EditPlayerCubit>();
        final isSubmissionInProgress =
            state.submissionStatus == SubmissionStatus.inProgress;
        final userFIError = state.userFI.isNotValid ? state.userFI.error : null;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            onChanged: cubit.onUserFIChanged,
            focusNode: _focusNode,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            controller: _controller,
            style: textFieldTextStyle(16),
            keyboardType: TextInputType.name,
            cursorColor: brandColorTextFieldBoard,
            decoration: textFieldInputDecoration(
              onClear: () {
                _controller.clear();
              },
              labelText: 'Фамилия, Имя игрока, ',
              hintText: 'Поляков Иван',
              suffixIcon: Icon(Icons.person, color: brandColorTextFieldBoard),
              enabled: !isSubmissionInProgress,
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
