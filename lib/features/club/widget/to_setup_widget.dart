
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/features/club/bloc/players/players_cubit.dart';

class ToSetupTourneyWidget extends StatelessWidget {
  const ToSetupTourneyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: 0,
      stream: context.read<PlayersCubit>().getAddedPlayersQnt(),
      builder: (context, snapshot) {
        return snapshot.data! > 5
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ConfirmButton(
                  buttonText: 'Подготовить турнир',
                  onTap: context.read<PlayersCubit>().tryToStartTourney,
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.only(top: 24.0, left: 8.0, right: 8.0),
                child: Text(
                  'Для начала турнира добавьте в клуб как миниму 6 человек',
                  style: AT.t.title2.theme,
                  textAlign: TextAlign.center,
                ),
              );
      },
    );
  }
}
