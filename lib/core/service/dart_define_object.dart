class DartDefineObject {
  final String version;
  final String _totalSeconds;
  final String _totalMinutes;
  final String _secondToEndMatch;

  int totalSeconds(){
    return int.tryParse(_totalSeconds) ?? 30;
  }

  int totalMinutes(){
    return int.tryParse(_totalMinutes) ?? 1;
  }

  int totalSecondsPerMatch(){
    return totalSeconds() * totalMinutes();
  }

  int secondToEndMatch(){
    return int.tryParse(_secondToEndMatch) ?? 15;
  }

  DartDefineObject._()
      :version = const String.fromEnvironment('version', defaultValue: 'dev'),
        _totalMinutes = const String.fromEnvironment('totalMinutes', defaultValue: '1'),
        _secondToEndMatch = const String.fromEnvironment('secondToEndMatch', defaultValue: '15'),
        _totalSeconds = const String.fromEnvironment('totalSeconds', defaultValue: '30');

  static final DartDefineObject _instance = DartDefineObject._();

  factory DartDefineObject(){
    return _instance;
  }

}