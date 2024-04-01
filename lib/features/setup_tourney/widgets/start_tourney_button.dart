import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/features/setup_tourney/bloc/bloc.dart';


class StartTourneyButton extends StatelessWidget {
  const StartTourneyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<bool>(
        initialData: false,
        stream: context.read<SetupTourneyCubit>().needToStart(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return ConfirmButton(
                buttonText: 'Провести турнир',
                onTap: () {
                  context.read<SetupTourneyCubit>().tryToStartTourney();
                },
              );
            }
          }
          return StreamBuilder<int>(
              stream: context.read<SetupTourneyCubit>().totalPlayers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Для старта турнира выберите ${snapshot.data} человек',
                    style: textStyleFormat(brand2ColorBase, 20.0),
                    textAlign: TextAlign.center,
                  );
                }
                return SizedBox();
              });
        },
      ),
    );
  }
}
