enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return '3xball demo';
      case Flavor.prod:
        return '3xBall prod';
      default:
        return 'title';
    }
  }

}
