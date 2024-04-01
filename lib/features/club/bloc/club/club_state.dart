part of 'club_cubit.dart';

class ClubState extends Equatable{
  final ClubDomain? clubDomain;
  const ClubState({this.clubDomain});

  @override
  List<Object?> get props => [clubDomain];
}

