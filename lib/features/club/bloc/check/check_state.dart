part of 'check_cubit.dart';

class CheckState extends Equatable {
  final CheckStatus status;
  final AppDomain? appDomain;

  const CheckState({required this.status, this.appDomain});

  @override
  List<Object> get props {
    return [status];
  }
}

enum CheckStatus {
  idle,
  created,
  failed,
}
