import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class Birthday extends FormzInput<String, BirthdayValidationError>
    with EquatableMixin {
  const Birthday.unvalidated([String value = '']) : super.pure(value);

  const Birthday.validated(
    String value,
  ) : super.dirty(value);

  static final _birthdayRegex = RegExp('^[\\d]{2}\\.[\\d]{2}\\.(19|20)[\\d]{2}\$');

  @override
  // TODO: implement props
  List<Object?> get props => [
        value,
        isPure,
      ];

  @override
  BirthdayValidationError? validator(String value) {
    return value.isEmpty
        ? BirthdayValidationError.empty
        : value.length < 10 ? BirthdayValidationError.little
        : value.length > 10 ? BirthdayValidationError.many
        : (_birthdayRegex.hasMatch(value))
            ? null
            : BirthdayValidationError.invalid;
  }
}

enum BirthdayValidationError {
  empty,
  many,
  little,
  invalid,
}
