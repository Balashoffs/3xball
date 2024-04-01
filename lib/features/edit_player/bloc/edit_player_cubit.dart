import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:three_x_ball/features/edit_player/form_fields/form_fields.dart';

part 'edit_player_state.dart';

class EditPlayerCubit extends Cubit<EditPlayerState> {
  EditPlayerCubit() : super(const EditPlayerState());

  void onUserFIChanged(String newValue) {
    String value = newValue.trim();
    final previous = state.userFI;
    final shouldValidate = previous.isNotValid;
    final newState = state.copyWith(
      userFI:
          shouldValidate ? UserFI.validated(value) : UserFI.unvalidated(value),
    );
    emit(newState);
  }

  void onUserFIFocused() {
    final newState =
        state.copyWith(userFI: UserFI.validated(state.userFI.value));

    emit(newState);
  }

  void onBirthdayChanged(String newValue) {
    final previous = state.birthday;
    final shouldValidate = previous.isNotValid;
    final newState = state.copyWith(
        birthday: shouldValidate
            ? Birthday.validated(newValue.trim())
            : Birthday.unvalidated(newValue.trim()));
    emit(newState);
  }

  void onBirthdayFocused() {
    final newState =
        state.copyWith(birthday: Birthday.validated(state.birthday.value));

    emit(newState);
  }

  void onPhoneNumberChanged(String newValue) {
    final previous = state.phoneNumber;
    final shouldValidate = previous.isNotValid;
    final newState = state.copyWith(
        phoneNumber: shouldValidate
            ? PhoneNumber.validated(newValue.trim())
            : PhoneNumber.unvalidated(newValue.trim()));
    emit(newState);
  }

  void onPhoneNumberFocused() {
    final newState = state.copyWith(
        phoneNumber: PhoneNumber.validated(state.phoneNumber.value));

    emit(newState);
  }

  void onSubmit() async {
    final userFI = UserFI.validated(state.userFI.value);
    final birthday = Birthday.validated(state.birthday.value);
    final phoneNumber = PhoneNumber.validated(state.phoneNumber.value);

    final isFormValid = Formz.validate([
      userFI,
      birthday,
      phoneNumber,
    ]);

    final newState = state.copyWith(
      userFI: userFI,
      birthday: birthday,
      phoneNumber: phoneNumber,
      submissionStatus:
          isFormValid ? SubmissionStatus.success : SubmissionStatus.error,
    );

    emit(newState);
  }
}
