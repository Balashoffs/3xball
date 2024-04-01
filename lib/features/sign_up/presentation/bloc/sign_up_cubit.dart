import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:three_x_ball/mapper/app_mapper.dart';
import 'package:three_x_ball/model/local_store/club_sp.dart';
import 'package:three_x_ball/repository/app_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../../model/local_store/manager_sp.dart';
import '../../form_fields/form_fields.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required AppRepository appRepository})
      : _appRepository = appRepository,
        super(SignUpState());

  final AppRepository _appRepository;



  void onClubUnFocused() {
    final newState =
        state.copyWith(clubName: ClubName.validated(state.clubName.value.trim()));

    emit(newState);
  }



  void onCityUnFocused() {
    final newState =
        state.copyWith(cityName: CityName.validated(state.cityName.value.trim()));

    emit(newState);
  }

  void onCountryNameChanged(String? newValue) {
    final previous = state.countryName;
    final shouldValidate = previous.isNotValid || newValue == null;
    final newState = state.copyWith(
        countryName: shouldValidate
            ? CountryName.validated(newValue ?? '')
            : CountryName.unvalidated(newValue));
    emit(newState);
  }

  void onCountryUnFocused() {
    final newState = state.copyWith(
        countryName: CountryName.validated(state.countryName.value));
    emit(newState);
  }

  void onUserFIChanged(String newValue) {
    final previous = state.userFI;
    final shouldValidate = previous.isNotValid;
    final newState = state.copyWith(
        userFI: shouldValidate
            ? UserFI.validated(newValue.trim())
            : UserFI.unvalidated(newValue.trim()));
    emit(newState);
  }

  void onClubNameChanged(String newValue) {
    final previousClubName = state.clubName;
    final shouldValidate = previousClubName.isNotValid;
    final newState = state.copyWith(
        clubName: shouldValidate
            ? ClubName.validated(newValue.trim())
            : ClubName.unvalidated(newValue.trim()));
    emit(newState);
  }

  void onCityNameChanged(String newValue) {
    final previousCityName = state.cityName;
    final shouldValidate = previousCityName.isNotValid;
    final newState = state.copyWith(
        cityName: shouldValidate
            ? CityName.validated(newValue.trim())
            : CityName.unvalidated(newValue.trim()));
    emit(newState);
  }

  void onUserFIFocused() {
    final newState =
        state.copyWith(userFI: UserFI.validated(state.userFI.value.trim()));

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
        state.copyWith(birthday: Birthday.validated(state.birthday.value.trim()));

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
        phoneNumber: PhoneNumber.validated(state.phoneNumber.value.trim()));

    emit(newState);
  }

  void onSubmit() async {
    final clubName = ClubName.validated(state.clubName.value);
    final cityName = CityName.validated(state.cityName.value);
    final countryName = state.countryName;
    final userFI = UserFI.validated(state.userFI.value);
    final birthday = Birthday.validated(state.birthday.value);
    final phoneNumber = PhoneNumber.validated(state.phoneNumber.value);

    final isFormValid = Formz.validate([
      clubName,
      cityName,
      userFI,
      birthday,
      phoneNumber,
      countryName,
    ]);

    final newState = state.copyWith(
      clubName: clubName,
      cityName: cityName,
      countryName: countryName,
      userFI: userFI,
      birthday: birthday,
      phoneNumber: phoneNumber,
      submissionStatus:
          isFormValid ? SubmissionStatus.success : SubmissionStatus.error,
    );

    emit(newState);
    ClubSP clubSP = newState.toClubSP();
    ManagerSP managerSP = newState.toManagerSP(SignUpState.id);
    _appRepository.createClub(clubSP);
    _appRepository.createManager(managerSP);
  }
}
