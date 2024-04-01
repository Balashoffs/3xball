import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'select_age_state.dart';

class SelectAgeCubit extends Cubit<SelectAgeState> {
  SelectAgeCubit() : super(const SelectAgeState());

  void selectCheckBox(bool isCheck){
    emit(SelectAgeState(isCheck));
  }
}
