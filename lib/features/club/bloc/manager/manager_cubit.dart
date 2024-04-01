import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/model/domain/manager_domain.dart';

import '../../../../../repository/app_repository.dart';

part 'manager_state.dart';

class ManagerCubit extends Cubit<ManagerState> {
  ManagerCubit({required this.repository}) : super(const ManagerState());

  Future<void> init() async{
    ManagerDomain managerDomain = await repository.readManager();
    if(managerDomain.id.isNotEmpty){
      emit(ManagerState(manager: managerDomain));
    }
  }

  final AppRepository repository;
}
