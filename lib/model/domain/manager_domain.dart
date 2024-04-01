import 'dart:typed_data';

class ManagerDomain {
  final String id;
  final String userFirstName;
  final String userLastName;
  final String birthday;
  final int age;
  final String phoneNumber;
  final Uint8List? photoAsBytes;
  final int totalGames;
  final int totalPlayers;
  final int rate;

  ManagerDomain({
    required this.id,
    required this.userFirstName,
    required this.userLastName,
    required this.birthday,
    required this.phoneNumber,
    this.totalGames = 0,
    this.totalPlayers = 0,
    this.rate = 0,
    this.photoAsBytes,
  }) : age = _setAge(birthday);

  static int _setAge(String birthday) {
    final dateNow = DateTime.now();
    final dateUser = DateTime.parse(birthday);
    final millsDelta =
        dateNow.millisecondsSinceEpoch - dateUser.millisecondsSinceEpoch;
    return (millsDelta / (1000 * 60 * 60 * 24 * 365)).round();
  }

  String get fullName => '$userLastName $userFirstName';

  ManagerDomain copyWith({
    required String id,
    required String userFirstName,
    required String userLastName,
    required String birthday,
    required String phoneNumber,
    required Uint8List? photoPath,
    required int? totalGames,
    required int? totalPlayers,
    required int? rate,
  }) {
    return ManagerDomain(
      id: id,
      userFirstName: userFirstName,
      userLastName: userLastName,
      birthday: birthday,
      phoneNumber: phoneNumber,
      photoAsBytes: photoPath ?? photoAsBytes,
      rate: rate ?? this.rate,
      totalGames: totalGames ?? this.totalGames,
      totalPlayers: totalPlayers ?? this.totalPlayers,
    );
  }

  ManagerDomain.empty()
      : id = '',
        userFirstName = '',
        userLastName = '',
        age = 0,
        rate = 0,
        totalGames = 0,
        totalPlayers = 0,
        birthday = '',
        phoneNumber = '',
        photoAsBytes = null;
}
