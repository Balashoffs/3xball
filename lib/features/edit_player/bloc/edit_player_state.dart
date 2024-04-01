part of 'edit_player_cubit.dart';

class EditPlayerState extends Equatable {
  const EditPlayerState({
    this.userFI = const UserFI.unvalidated(),
    this.birthday = const Birthday.unvalidated(),
    this.phoneNumber = const PhoneNumber.unvalidated(),
    this.submissionStatus = SubmissionStatus.idle,
  });

  final UserFI userFI;
  final Birthday birthday;
  final PhoneNumber phoneNumber;
  final SubmissionStatus submissionStatus;

  EditPlayerState copyWith({
    UserFI? userFI,
    Birthday? birthday,
    PhoneNumber? phoneNumber,
    SubmissionStatus? submissionStatus,
  }) {
    return EditPlayerState(
      userFI: userFI ?? this.userFI,
      birthday: birthday ?? this.birthday,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [
        userFI,
        birthday,
        phoneNumber,
        submissionStatus,
      ];
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  error,
}
