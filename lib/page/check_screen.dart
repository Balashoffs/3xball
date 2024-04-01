import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/features/club/bloc/check/check_cubit.dart';
import 'package:three_x_ball/repository/app_repository.dart';


class CheckScreen extends StatelessWidget {
  const CheckScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ExtendedScaffoldWidget(
      child: CheckBlocWidget(),
    );
  }
}

class CheckBlocWidget extends StatelessWidget {
  const CheckBlocWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRepository = context.read<AppRepository>();
    return BlocProvider<CheckCubit>(
      create: (context) =>
          CheckCubit(appRepository: appRepository)..checkClub(),
      lazy: false,
      child: CheckWidget(
        onCreateClub: () {
          Navigator.pushNamed(
            context,
            '/welcome',
          );
        },
        onEnterLobby: () {
          Navigator.pushNamed(
            context,
            '/club',
          );
        },
      ),
    );
  }
}

class CheckWidget extends StatelessWidget {
  const CheckWidget({
    Key? key,
    required this.onCreateClub,
    required this.onEnterLobby,
  }) : super(key: key);
  final VoidCallback onCreateClub;
  final VoidCallback onEnterLobby;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckCubit, CheckState>(
      listener: (context, state) {
        if (state.status == CheckStatus.failed) {
          onCreateClub();
        }
        if (state.status == CheckStatus.created) {
          onEnterLobby();
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash/background.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
