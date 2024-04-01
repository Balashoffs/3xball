import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/model/country_set.dart';


import '../bloc/sign_up_cubit.dart';
import 'package:three_x_ball/core/utils/utils.dart';

class CountryTextField extends StatefulWidget {
  const CountryTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<CountryTextField> createState() => _CountryTextFieldState();
}

class _CountryTextFieldState extends State<CountryTextField> {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();
        final isSubmissionStatus =
            state.submissionStatus == SubmissionStatus.inProgress;
        final countryError =
            state.countryName.isNotValid ? state.countryName.error : null;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: DropdownButtonFormField<String>(
            focusNode: _focusNode,
            items: countryOfCISList.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: AT.t.body1.theme,
                ),
              );
            }).toList(),
            onChanged: cubit.onCountryNameChanged,
            dropdownColor: brandColorBaseBackground,
            focusColor: brandColorTextFieldBoard,
            alignment: Alignment.centerLeft,
            style: AT.t.body1.theme,
            decoration: dropdownMenuInputDecoration(
              enabled: !isSubmissionStatus,
              labelText: 'Страна',
              hintText: 'Страна',
              errorText: countryError == null ? null : 'Необходимо выбрать страну',
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
        cubit.onCountryUnFocused();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
