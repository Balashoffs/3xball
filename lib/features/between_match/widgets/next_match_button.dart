import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/features/between_match/bloc/between_match_cubit.dart';

class NextMatchButton extends StatelessWidget {
  const NextMatchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status =
    context.select((BetweenMatchCubit cubit) => cubit.state.status);
    return ConfirmButton(
      onTap: status != BetweenMatchStatus.finish
          ? () {
        Navigator.pushNamed(
          context,
          '/match',
        ).then((value) {
          context.read<BetweenMatchCubit>().nextMatch();
        });
      }
          : () {
        Navigator.pushNamed(
          context,
          '/end_tourney',
        ).then((value) => context.read<BetweenMatchCubit>().close());
      },
      buttonText: status != BetweenMatchStatus.finish
          ? 'Начать матч'
          : 'Подсчитать результаты',
    );
  }
}