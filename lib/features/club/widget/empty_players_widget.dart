import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/club/bloc/players/players_cubit.dart';
import 'add_player_button.dart';

class EmptyPlayersWidget extends StatelessWidget {
  const EmptyPlayersWidget({
    Key? key,
    required this.width,
    required this.right,
  }) : super(key: key);

  final double width, right;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              textAlign: TextAlign.center,
              'Для проведения турниров в клуб нужно добавить минимум 6 игроков',
              style: textStyle(
                brand2ColorBase,
                16.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: AddPlayerButton(
                  right: right,
                  onAdd: (player) {
                    context.read<PlayersCubit>().addPlayer(player);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
