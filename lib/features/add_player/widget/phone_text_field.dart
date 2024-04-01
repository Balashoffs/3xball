import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/add_player/bloc/add_player_cubit.dart';
import 'package:three_x_ball/features/add_player/form_fields/phone_number.dart';

class PhoneTextField extends StatefulWidget {
  const PhoneTextField({Key? key}) : super(key: key);

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPlayerCubit, AddPlayerState>(
      builder: (context, state) {
        final cubit = context.read<AddPlayerCubit>();
        final phoneNumberError =
            state.phoneNumber.isNotValid ? state.phoneNumber.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == SubmissionStatus.inProgress;

        return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            onChanged: cubit.onPhoneNumberChanged,
            focusNode: _focusNode,
            controller: _controller,
            autocorrect: false,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            style: textFieldTextStyle(16),
            cursorColor: brandColorTextFieldBoard,
            decoration: textFieldInputDecoration(
              onClear: () {
                _controller.clear();
              },
              labelText: 'Телефон',
              hintText: '+79139000715',
              suffixIcon: Icon(Icons.phone, color: brandColorTextFieldBoard),
              enabled: !isSubmissionInProgress,
              errorText: phoneNumberError == null
                  ? null
                  : phoneNumberError == PhoneNumberValidationError.empty
                      ? 'Поле не должно быть пустым'
                      : 'Неверный набор символов',
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        final cubit = context.read<AddPlayerCubit>();
        cubit.onPhoneNumberFocused();
      }
    });

    _controller.addListener(() {
      int currentPos = _controller.text.length;
      if (currentPos == 0) {
        String newValue = '+7${_controller.text}';
        _controller.value = TextEditingValue(
          text: newValue,
          selection: TextSelection.fromPosition(
            TextPosition(offset: newValue.length),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
