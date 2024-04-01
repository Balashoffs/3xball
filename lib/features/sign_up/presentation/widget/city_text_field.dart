import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/sign_up/form_fields/city_name.dart';
import 'package:three_x_ball/features/sign_up/presentation/bloc/sign_up_cubit.dart';

class CityTextField extends StatefulWidget {
  const CityTextField({Key? key}) : super(key: key);

  @override
  State<CityTextField> createState() => _CityTextFieldState();
}

class _CityTextFieldState extends State<CityTextField> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();
        final isSubmissionInProgress =
            state.submissionStatus == SubmissionStatus.inProgress;
        final cityError =
            state.cityName.isNotValid ? state.cityName.error : null;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            focusNode: _focusNode,
            controller: _controller,
            keyboardType: TextInputType.name,
            onChanged: cubit.onCityNameChanged,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            style: AT.t.body1.theme,
            cursorColor: brandColorTextFieldBoard,
            decoration: textFieldInputDecoration(
              onClear: () {
                _controller.clear();
              },
              labelText: 'Город',
              enabled: !isSubmissionInProgress,
              hintText: 'Москва',
              suffixIcon: Icon(
                Icons.location_city,
                color: brandColorTextFieldBoard,
              ),
              errorText: cityError == null
                  ? null
                  : cityError == CityNameValidationError.empty
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
        final cubit = context.read<SignUpCubit>();
        cubit.onCityUnFocused();
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
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
