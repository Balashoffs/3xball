import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:three_x_ball/repository/i_app_store.dart';

import '../../model/local_store/manager_sp.dart';

class ManagerSharedPref extends IManagerStore{
  static const String key = 'manager';
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<bool> existed() async{
    return await prefs.then((value) => value.containsKey(key));
  }

  @override
  Future<ManagerSP> read() async{
    String? managerAsJson =  await prefs.then((value) => value.getString(key));
    if(managerAsJson != null){
      return ManagerSP.fromJson(jsonDecode(managerAsJson));
    }
    return ManagerSP.empty();
  }

  @override
  Future<void> create(ManagerSP managerSP) async{
    String managerAsJson = jsonEncode(managerSP.toJson());
    await prefs.then((value) => value.setString(key, managerAsJson));
  }

  @override
  Future<void> update(ManagerSP managerSP) async{
    String managerAsJson = jsonEncode(managerSP.toJson());
    await prefs.then((value){
      value.remove(key);
      value.setString(key, managerAsJson);
    });
  }
}