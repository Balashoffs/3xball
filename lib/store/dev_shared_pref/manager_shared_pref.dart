import 'package:shared_preferences/shared_preferences.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/repository/i_app_store.dart';

import '../../model/local_store/manager_sp.dart';

class DevManagerSharedPref extends IManagerStore{
  Future<bool> existed() async{
    return true;
  }

  @override
  Future<ManagerSP> read() async{
    return getManager();
  }

  @override
  Future<void> create(ManagerSP managerSP) async{
  }

  @override
  Future<void> update(ManagerSP managerSP) async{
  }
}