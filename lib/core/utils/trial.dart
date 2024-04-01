import 'package:shared_preferences/shared_preferences.dart';

const String timeStampKey = 'timeStamp';
const _appdHJpYWwKey = 'dHJpYWw';
const _appdHJpYWwValue = String.fromEnvironment(
  _appdHJpYWwKey,defaultValue: '2024-05-18_23:59'
);

Future<TrialResult> checkOnEndTrial() async {
  final currentTimeStamp = DateTime.now().millisecondsSinceEpoch;

  String dateAsString = _appdHJpYWwValue.replaceAll('_', ' ');

  return await SharedPreferences.getInstance().then((value) {
    bool isOnTrial = false;
    if (value.containsKey(timeStampKey)) {
      final lastTimeStamp = value.getInt(timeStampKey);
      isOnTrial = currentTimeStamp - lastTimeStamp! > 0;
    }
    if (isOnTrial || !value.containsKey(timeStampKey)) {
      isOnTrial = DateTime.parse(dateAsString).millisecondsSinceEpoch -
          currentTimeStamp >
          0;
    }

    value.remove(timeStampKey);
    value.setInt(timeStampKey, currentTimeStamp);
    return TrialResult(dateEnd: dateAsString, isOnTrial: isOnTrial);
  });
}

class TrialResult {
  final bool isOnTrial;
  final String dateEnd;

  TrialResult({required this.isOnTrial, required this.dateEnd});

  String get message => isOnTrial
      ? 'Приложение можно использовать до $dateEnd'
      : 'Время пользования программой закончилось: $dateEnd';
}