import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/utils/colors.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/features/match/bloc/match_cubit.dart';
import 'package:three_x_ball/features/match/widgets/widgets.dart';

class ContinueMatchButton extends StatelessWidget {
  const ContinueMatchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((MatchCubit cubit) => cubit.state.status);
    return status == MatchStatus.selected
        ? Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            child: ConfirmButton(
              buttonText: 'Продолжить матч',
              onTap: () {
                context.read<MatchCubit>().onCancel();
              },
              backgroundColor: brandColorBase,
            ),
          )
        :  const SizedBox.shrink();
  }
}
