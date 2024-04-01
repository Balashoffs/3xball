
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/club/bloc/bloc.dart';
import 'package:three_x_ball/model/domain/domain.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SetupHeaderWidget extends StatelessWidget {
  const SetupHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/setup_tourney/head_background.png',
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ClubHead(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  color: brand2ColorBase,
                ),
              ),
            ],
          ),
          const SelectPlayersAgesWidget(),
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

class SelectPlayersAgesWidget extends StatelessWidget {
  const SelectPlayersAgesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'фильтр',
                style: AT.t.title2.theme,
            ),
            CustomCheckButton(
              onChanged: (value) {
                context.read<SelectAgeCubit>().selectCheckBox(value!);
                if (value) {
                  context.read<PlayersCubit>().onAgeToggle(range: [9, 11]);
                } else {
                  context.read<PlayersCubit>().onReset();
                }
              },
            ),
          ],
        ),
        BlocBuilder<SelectAgeCubit, SelectAgeState>(
          buildWhen: (previous, current) =>
          previous.isSelect != current.isSelect,
          builder: (context, state) {
            return state.isSelect ? ToggleSelectedPlayer() : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class ToggleSelectedPlayer extends StatelessWidget {
  ToggleSelectedPlayer({
    Key? key,
  }) : super(key: key);
  final Map<int, List<int>> ages = {
    0: [9, 11],
    1: [12, 14],
    2: [15, 17],
    3: [18, 35],
    4: [35, 50],
    5: [50, 100]
  };

  @override
  Widget build(BuildContext context) {
    return CustomToggleWidget(
      labels: const ['9-11', '12-14', '15-17', '18+', '35+', '50+'],
      onToggleEvent: (index) {
        final range = ages[index] ?? [9, 11];
        context.read<PlayersCubit>().onAgeToggle(range: range);
      },
    );
  }
}

class CustomCheckButton extends StatefulWidget {
  const CustomCheckButton({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<CustomCheckButton> createState() => _CustomCheckButtonState();
  final ValueChanged<bool?> onChanged;
}

class _CustomCheckButtonState extends State<CustomCheckButton> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isCheck,
      onChanged: (value) {
        widget.onChanged(value);
        isCheck = value!;
        setState(() {});
      },
      checkColor: brandColorBase,
      activeColor: brand2ColorBase,
      hoverColor: brandColorBase,
      focusColor: brandColorBase,
      side: BorderSide(
        color: brandColorBase,
        width: 1.5,
      ),
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
  final ScrollController _scrollController = ScrollController();

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        interactive: true,
        thickness: 8.0,
        radius: Radius.circular(2.0),
        // trackVisibility: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAlias,
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            // padding: EdgeInsets.only(left: 8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ToggleSwitch(
                minWidth: 326.0,
                // minHeight: 50.0,
                initialLabelIndex: lastToggleIndex,
                activeBgColor: [brandColorBase],
                // cornerRadius: 22.0,
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
                centerText: true,
                dividerColor: brand2ColorBase,
                customWidths:
                List.generate(toggleTextStyles.length, (index) => 100.0),
              ),
            ),
          ),
        ),
      ),
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