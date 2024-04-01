import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class UserFI extends FormzInput<String, UserFIValidationError>
    with EquatableMixin {
  const UserFI.unvalidated([String value = '']) : super.pure(value);

  const UserFI.validated(
    String value,
  ) : super.dirty(value);

  static final _userFIRegex = RegExp('^[А-ЯЁ][а-яё]{3,10}\\s[А-ЯЁ][а-яё]{3,10}\$');

  @override
  // TODO: implement props
  List<Object?> get props => [
        value,
        isPure,
      ];

  @override
  UserFIValidationError? validator(String value) {
    return value.isEmpty
        ? UserFIValidationError.empty
        : (_userFIRegex.hasMatch(value))
            ? null
            : UserFIValidationError.invalid;
  }
}

enum UserFIValidationError {
  empty,
  invalid,
}
