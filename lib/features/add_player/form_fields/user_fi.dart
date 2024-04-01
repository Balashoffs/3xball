import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class UserFI extends FormzInput<String, UserFIValidationError>
    with EquatableMixin {
  const UserFI.unvalidated([String value = '']) : super.pure(value);

  const UserFI.validated(
    String value,
  ) : super.dirty(value);

  static final _userFIRegex =
      RegExp('^[А-ЯЁ][а-яё]{3,10}\\s[А-ЯЁ][а-яё]{2,10}\$');
  static final _userNameRegex = RegExp('^[А-ЯЁ][а-яё]{3,10}\$');
  static final _userNameSpaceRegex = RegExp('^[А-ЯЁ][а-яё]{3,10}\\s\$');

  @override
  List<Object?> get props => [
        value,
        isPure,
      ];

  @override
  UserFIValidationError? validator(String value) {
    return value.isEmpty
        ? UserFIValidationError.empty
        : _userFIRegex.hasMatch(value)
            ? null
            : (_userNameRegex.hasMatch(value) | _userNameSpaceRegex.hasMatch(value))
                ? UserFIValidationError.little
                : UserFIValidationError.invalid;
  }
}

enum UserFIValidationError {
  empty,
  little,
  invalid,
}
