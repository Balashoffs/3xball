import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class CountryName extends FormzInput<String, CountryNameValidationError>
    with EquatableMixin {
  const CountryName.unvalidated([String value = '']) : super.pure(value);

  const CountryName.validated(
    String value,
  ) : super.dirty(value);

  static final _countryNameRegex = RegExp('^(Страна)\$');

  @override
  List<Object?> get props => [
        value,
        isPure,
      ];

  @override
  CountryNameValidationError? validator(String value) {
    bool isCountryEmpty = _countryNameRegex.hasMatch(value);
    return value.isEmpty
        ? CountryNameValidationError.empty
        : (!isCountryEmpty || value.isNotEmpty)
            ? null
            : CountryNameValidationError.invalid;
  }
}

enum CountryNameValidationError {
  empty,
  invalid,
}
