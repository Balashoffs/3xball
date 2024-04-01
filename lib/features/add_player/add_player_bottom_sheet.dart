
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/widget/register_button.dart';
import 'package:three_x_ball/features/add_player/widget/add_user_widget.dart';
import 'package:three_x_ball/mapper/player_mapper.dart';
import 'package:three_x_ball/model/domain/domain.dart';


import 'bloc/add_player_cubit.dart';

class AddPlayerWidget extends StatelessWidget {
  const AddPlayerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2 - 50;
    List<Widget> widgets = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Divider(
          height: 4.0,
          color: Colors.white,
          indent: width,
          endIndent: width,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 16.0, bottom: 8.0),
        child: Text(
          'Введите данные',
            style: AT.t.title2.theme,
        ),
      ),
      const PlayerFITextField(),
      const BirthdayTextField(),
      const PhoneTextField(),
      Center(
        child: ConfirmButton(
            buttonText: 'Добавить игрока',
            onTap: () {
              context.read<AddPlayerCubit>().onSubmit();
            }),
      ),
    ];

    return BlocConsumer<AddPlayerCubit, AddPlayerState>(
      listener: (context, state) {
        if (state.submissionStatus == SubmissionStatus.success) {
          UserDM player = state.toPlayer();
          Navigator.of(context).pop(player);
        }
      },
      builder: (context, state) {
        return Wrap(
          children: widgets,
        );
      },
    );
  }
}
