import 'package:three_x_ball/repository/app_store.dart';

import 'flavors.dart';

import 'main_entry.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.prod;
  await runner.entry(() => ProdAppStore());
}
