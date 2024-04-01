import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class ClubName extends FormzInput<String, ClubNameValidationError>
    with EquatableMixin {
  const ClubName.unvalidated([String value = '']) : super.pure(value);

  const ClubName.validated(
    String value,
  ) : super.dirty(value);

  static final _clubNameRegex = RegExp('^[a-zA-Zа-яёА-ЯЁ0-9]{3,10}\$');

  @override
  List<Object?> get props => [
        value,
        isPure,
      ];

  @override
  ClubNameValidationError? validator(String value) {
    return value.isEmpty
        ? ClubNameValidationError.empty
        : (_clubNameRegex.hasMatch(value))
            ? null
            : ClubNameValidationError.invalid;
  }
}

enum ClubNameValidationError {
  empty,
  invalid,
}
