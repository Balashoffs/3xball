part of 'select_age_cubit.dart';

class SelectAgeState extends Equatable {
  final bool isSelect;

  const SelectAgeState([this.isSelect = false]);

  @override
  List<Object> get props => [isSelect];
}
