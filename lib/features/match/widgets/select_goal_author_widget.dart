import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/features/match/bloc/bloc.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/core/widget/register_button.dart';

class SelectGoalAuthorWidget extends StatelessWidget {
  const SelectGoalAuthorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((MatchCubit cubit) => cubit.state.status);
    return status == MatchStatus.selected
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConfirmButton(
                  buttonText: 'Потвердить выбор',
                  onTap: () {
                    context.read<MatchCubit>().onConfirm();
                  },
                  backgroundColor: managerHeadColor,
                ),
            )
            : const SizedBox.shrink();
  }
}
