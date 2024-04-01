import 'club_domain.dart';
import 'manager_domain.dart';
import 'user_domain.dart';

class AppDomain {
  final ClubDomain club;
  final ManagerDomain manager;
  final List<UserDM> players;

  AppDomain({
    required this.manager,
    required this.club,
    this.players = const [],
  });

  AppDomain.only({
    ClubDomain? club,
    ManagerDomain? manager,
    List<UserDM>? players,
  })  : club = club ?? ClubDomain.empty(),
        manager = manager ?? ManagerDomain.empty(),
        players = players ?? [];

  AppDomain copyWith({
    ClubDomain? club,
    ManagerDomain? manager,
    List<UserDM>? players,
    String? clubPhoto,
  }) {
    return AppDomain(
      club: club ?? this.club,
      manager: manager ?? this.manager,
      players: players ?? this.players,
    );
  }

  AppDomain.empty()
      : club = ClubDomain.empty(),
        players = [],
        manager = ManagerDomain.empty();
}
