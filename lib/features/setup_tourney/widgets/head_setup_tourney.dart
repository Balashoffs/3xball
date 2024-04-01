import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/setup_tourney/bloc/bloc.dart';
import 'package:three_x_ball/model/domain/domain.dart';
import 'package:toggle_switch/toggle_switch.dart';


class SetupHeaderWidget extends StatelessWidget {
  const SetupHeaderWidget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/setup_tourney/head_background.png',
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: brand2ColorBase,
                    ),
                  ),
                  const ClubHead(),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  color: brand2ColorBase,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SelectMatchPeriodWidget(),
          const SizedBox(
            height: 8,
          ),
          // SelectPlayersAgesWidget(),

          const SelectedPlayersWidget(),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}

class ClubHead extends StatelessWidget {
  const ClubHead({
    Key? key,
  }) : super(key: key);
  static const String pathToAddClubLogo = 'assets/club_lobby/add_club_logo.svg';
  static const String pathToClubLogo = 'assets/club_lobby/3xball_app_logo.png';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClubCubit, ClubState>(
      builder: (context, state) {
        if (state.clubDomain != null) {
          ClubDomain clubDomain = state.clubDomain!;
          return Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 4.0),
            child: Row(
              children: [
                clubDomain.clubPhoto.isEmpty
                    ? GestureDetector(
                  onTap: () {},
                  // child: SvgPicture.asset(pathToAddClubLogo, width: 72.0),
                  child: Image.asset(pathToClubLogo),
                )
                    : Image.memory(clubDomain.clubPhotoAsBytes()),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clubDomain.clubName,
                      style: AT.t.title4.theme,
                    ),
                    Text(
                      '${clubDomain.countryName}, ${clubDomain.cityName}',
                      style: AT.t.title4.theme,
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class SelectedPlayersWidget extends StatelessWidget {
  const SelectedPlayersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.7,
          // ),
          Text(
            'Вы выбрали',
              style: AT.t.body1.theme,
          ),
          const SizedBox(
            width: 8,
          ),
          StreamBuilder<int>(
              stream: context.read<SetupTourneyCubit>().selectedPlayers(),
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
                    style: AT.t.title1.theme,
                );
              }),
        ],
      ),
    );
  }
}

class SelectMatchPeriodWidget extends StatelessWidget {
  SelectMatchPeriodWidget({Key? key}) : super(key: key);
  final List<String> total = ['6', '8', '9'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Выбрать количество игроков',
          style: AT.t.body1.theme,
        ),
        const SizedBox(
          height: 12,
        ),
        CustomToggleWidget(
          labels: total,
          onToggleEvent: (index) {
            String totalStr = total[index!];
            int totalInt = int.parse(totalStr);
            context.read<SetupTourneyCubit>().onTotalPlayersToggle(totalInt);
          },
        ),
      ],
    );
  }
}

class CustomToggleWidget extends StatefulWidget {
  const CustomToggleWidget({
    Key? key,
    required this.labels,
    required this.onToggleEvent,
  }) : super(key: key);
  final List<String> labels;
  final OnToggle onToggleEvent;

  @override
  State<CustomToggleWidget> createState() => _CustomToggleWidgetState();
}

class _CustomToggleWidgetState extends State<CustomToggleWidget> {
  List<TextStyle> toggleTextStyles = [];
  int lastToggleIndex = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.labels.length; i++) {
      if (i == 0) {
        toggleTextStyles.add(selected);
      } else {
        toggleTextStyles.add(custom);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 326.0,
      centerText: true,
      initialLabelIndex: lastToggleIndex,
      activeBgColor: [brandColorBase],
      activeFgColor: brand2ColorBase,
      inactiveBgColor: brandColorBaseBackground,
      inactiveFgColor: brand2ColorBase,
      totalSwitches: toggleTextStyles.length,
      labels: widget.labels,
      onToggle: (index) {
        changeStyle(index ?? -1);
        widget.onToggleEvent(index);
      },
      customTextStyles: toggleTextStyles,
      dividerColor: brand2ColorBase,
    );
  }

  void changeStyle(int index) {
    if (index == -1) return;
    if (index == lastToggleIndex) return;
    toggleTextStyles.removeAt(index);
    toggleTextStyles.insert(index, selected);
    toggleTextStyles.removeAt(lastToggleIndex);
    toggleTextStyles.insert(lastToggleIndex, custom);

    lastToggleIndex = index;

    setState(() {});
  }
}