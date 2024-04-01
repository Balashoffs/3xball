import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/add_player/add_player_bottom_sheet.dart';
import 'package:three_x_ball/features/add_player/bloc/add_player_cubit.dart';
import 'package:three_x_ball/model/domain/user_domain.dart';

import 'club_players_table_widget.dart';

class AddPlayerButton extends StatelessWidget {
  const AddPlayerButton({Key? key, required this.onAdd, required this.right}) : super(key: key);
  final OnAddPlayer onAdd;
  final double right;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(right: right, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: brand3ColorBase,
              borderRadius: const BorderRadius.all(Radius.circular(10.0))
            ),
            child: IconButton(
              icon: Icon(Icons.add, color: brand2ColorBase),
              onPressed: () async {
                UserDM? newPlayer = await showModalBottomSheet(
                    constraints: BoxConstraints.tight(Size(
                        MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height * 0.8)),
                    isScrollControlled: true,
                    context: context,
                    // isDismissible: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    backgroundColor: managerHeadColor,
                    builder: (builder) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: BlocProvider<AddPlayerCubit>(
                            create: (context) => AddPlayerCubit(),
                            child: const AddPlayerWidget(),
                          ),
                        ),
                      );
                    });

                if(newPlayer != null){
                  onAdd(newPlayer);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}