import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class CityName extends FormzInput<String, CityNameValidationError>
    with EquatableMixin {
  const CityName.unvalidated([String value = '']) : super.pure(value);

  const CityName.validated(
    String value,
  ) : super.dirty(value);

  static final _cityNameRegex = RegExp('^[а-яА-Я]{3,20}\$');

  @override
  // TODO: implement props
  List<Object?> get props => [
        value,
        isPure,
      ];

  @override
  CityNameValidationError? validator(String value) {
    return value.isEmpty
        ? CityNameValidationError.empty
        : (_cityNameRegex.hasMatch(value))
            ? null
            : CityNameValidationError.invalid;
  }
}

enum CityNameValidationError {
  empty,
  invalid,
}
