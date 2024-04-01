part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.clubName = const ClubName.unvalidated(),
    this.cityName = const CityName.unvalidated(),
    this.userFI = const UserFI.unvalidated(),
    this.birthday = const Birthday.unvalidated(),
    this.phoneNumber = const PhoneNumber.unvalidated(),
    this.countryName = const CountryName.unvalidated(),
    this.submissionStatus = SubmissionStatus.idle,
  });

  final ClubName clubName;
  final CityName cityName;
  final UserFI userFI;
  final Birthday birthday;
  final PhoneNumber phoneNumber;
  final SubmissionStatus submissionStatus;
  final CountryName countryName;
  static String id = const Uuid().v1();

  SignUpState copyWith({
    ClubName? clubName,
    CityName? cityName,
    UserFI? userFI,
    Birthday? birthday,
    PhoneNumber? phoneNumber,
    SubmissionStatus? submissionStatus,
    CountryName? countryName,
  }) {
    return SignUpState(
      clubName: clubName ?? this.clubName,
      cityName: cityName ?? this.cityName,
      userFI: userFI ?? this.userFI,
      birthday: birthday ?? this.birthday,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      countryName: countryName ?? this.countryName,
    );
  }

  @override
  List<Object> get props => [
        clubName,
        cityName,
        userFI,
        birthday,
        phoneNumber,
        submissionStatus,
        countryName
      ];
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  error,
}
