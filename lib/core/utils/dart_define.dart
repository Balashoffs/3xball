class DartDefine {
  static const customerBuild =
      String.fromEnvironment('customer', defaultValue: 'dev');
  static String version = const String.fromEnvironment('version',
      defaultValue: 'dev');
  static String buildId = String.fromEnvironment('buildId',
      defaultValue: 'demo-${DateTime.now().toString()}');
  static String endTrialPeriod = String.fromEnvironment('trial',
      defaultValue: '${DateTime.parse('2100-12-31 23:59:59')}');
}
