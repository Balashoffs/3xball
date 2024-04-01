import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class UserNick extends FormzInput<String, UserNickValidationError>
    with EquatableMixin {
  const UserNick.unvalidated([String value = '']) : super.pure(value);

  const UserNick.validated(
    String value,
  ) : super.dirty(value);

  static final _userNickRegex = RegExp('^[A-ZА-ЯЁa-zа-яё]{3,10}\$');

  @override
  List<Object?> get props => [
        value,
        isPure,
      ];

  @override
  UserNickValidationError? validator(String value) {
    return value.isEmpty
        ? UserNickValidationError.empty
        : (_userNickRegex.hasMatch(value))
            ? null
            : UserNickValidationError.invalid;
  }
}

enum UserNickValidationError {
  empty,
  invalid,
}
