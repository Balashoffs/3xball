import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError>
    with EquatableMixin {
  const PhoneNumber.unvalidated([String value = '']) : super.pure(value);

  const PhoneNumber.validated(
    String value,
  ) : super.dirty(value);

  static final _phoneNumberRegex = RegExp('^\\+7[\\d]{10}\$');

  @override
  // TODO: implement props
  List<Object?> get props => [
        value,
        isPure,
      ];

  @override
  PhoneNumberValidationError? validator(String value) {
    return value.isEmpty
        ? PhoneNumberValidationError.empty
        : value.length < 12
            ? PhoneNumberValidationError.little
            : value.length > 12
                ? PhoneNumberValidationError.many
                : (_phoneNumberRegex.hasMatch(value))
                    ? null
                    : PhoneNumberValidationError.invalid;
  }
}

enum PhoneNumberValidationError {
  empty,
  little,
  many,
  invalid,
}
