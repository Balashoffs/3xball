import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/features/edit_player/widget/add_user_widget.dart';
import 'package:three_x_ball/mapper/player_mapper.dart';
import 'package:three_x_ball/model/domain/domain.dart';


import 'bloc/edit_player_cubit.dart';

class EditPlayerWidget extends StatelessWidget {
  const EditPlayerWidget({
    Key? key,
    required this.playerForEditing,
  }) : super(key: key);
  final UserDM playerForEditing;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2 - 50;
    return BlocConsumer<EditPlayerCubit, EditPlayerState>(
      listener: (context, state) {
        if (state.submissionStatus == SubmissionStatus.success) {
          UserDM player = state.toPlayer(playerForEditing.id);
          if (player != playerForEditing) {
            Navigator.of(context).pop(player);
          } else {
            Navigator.of(context).pop();
          }
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView(
                primary: false,
                shrinkWrap: true,
                children: [
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
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 16.0, bottom: 8.0),
                    child: Text(
                      'Редактирование данных',
                      style: textStyle(userListHeadColor, 16.0),
                    ),
                  ),
                  PlayerFITextField(fullName: playerForEditing.fullName),
                  BirthdayTextField(birthday: playerForEditing.birthday),
                  PhoneTextField(phone: playerForEditing.phoneNumber),
                  Center(
                    child: ConfirmButton(
                        buttonText: 'Редактировать',
                        onTap: () {
                          context.read<EditPlayerCubit>().onSubmit();
                        }),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
