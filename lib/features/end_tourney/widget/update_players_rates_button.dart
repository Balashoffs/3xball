import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/features/end_tourney/bloc/end_tourney_cubit.dart';

class UpdatePlayerRateButton extends StatelessWidget {
  const UpdatePlayerRateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmButton(
      buttonText: 'Возврат в клуб',
      onTap: context.read<EndTourneyCubit>().updateLocalStore,
    );
  }
}