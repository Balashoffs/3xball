import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:three_x_ball/features/add_player/form_fields/form_fields.dart';


part 'add_player_state.dart';

class AddPlayerCubit extends Cubit<AddPlayerState> {
  AddPlayerCubit() : super(const AddPlayerState());

  void onUserFIChanged(String newValue) {
    String value =newValue.trim();
    final previous = state.userFI;
    final shouldValidate = previous.isNotValid;
    final newState = state.copyWith(
        userFI: shouldValidate
            ? UserFI.validated(value)
            : UserFI.unvalidated(value));
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
            ? Birthday.validated(newValue)
            : Birthday.unvalidated(newValue));
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
            ? PhoneNumber.validated(newValue)
            : PhoneNumber.unvalidated(newValue));
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
