import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/match/bloc/bloc.dart';

class MatchHeaderWidget extends StatelessWidget {
  const MatchHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: managerHeadColor,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MatchIndexWidget(),
          MatchResultWidget(),
          MenuButtonWidget(),
        ],
      ),
    );
  }
}

class MatchIndexWidget extends StatelessWidget {
  const MatchIndexWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MatchStatus matchStatus = context.select((MatchCubit cubit) => cubit.state.status);
    if(matchStatus != MatchStatus.selecting){
      int matchItem = context.select((MatchCubit cubit) => cubit.state.matchItem);
      return Text(
        'Матч #$matchItem',
        style: AT.t.title3.theme,
      );
    }
    return SizedBox.shrink();
  }
}

class MatchResultWidget extends StatelessWidget {
  const MatchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MatchCubit>();
    final score = cubit.state.matchScore;
    if (score.isEmpty) return const SizedBox.shrink();
    if (cubit.state.status == MatchStatus.selecting) {
      return Text(
        'Выберите автора гола',
        style: textStyleBold(Colors.white, 30.0),
      );
    }
    return Text(
      '${cubit.state.matchScore[0]} : ${cubit.state.matchScore[1]}',
      style: textStyleBold(Colors.white, 30.0),
    );
  }
}

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((MatchCubit cubit) => cubit.state.status);
    if (status == MatchStatus.selected) {
      return IconButton(
        onPressed: () {
          context.read<MatchCubit>().onCancel();
        },
        icon: Icon(
          Icons.close,
          color: brand2ColorBase,
          size: 24,
        ),
      );
    }
    if(status == MatchStatus.selecting){
      return SizedBox.shrink();
    }
    return IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.menu,
          color: brand2ColorBase,
          size: 24,
        ));
  }
}
