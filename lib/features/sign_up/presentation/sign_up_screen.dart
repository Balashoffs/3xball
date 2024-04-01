import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/features/sign_up/presentation/widget/club_text_field.dart';
import 'package:three_x_ball/features/sign_up/presentation/widget/register_buton.dart';
import 'package:three_x_ball/mapper/app_mapper.dart';
import 'package:three_x_ball/model/domain/club_domain.dart';
import 'package:three_x_ball/model/domain/domain.dart';
import 'package:three_x_ball/model/domain/manager_domain.dart';
import 'package:three_x_ball/repository/app_repository.dart';
import 'package:three_x_ball/features/sign_up/presentation/bloc/sign_up_cubit.dart';


import 'widget/birthday_text_field.dart';
import 'widget/city_text_field.dart';
import 'widget/country_text_field.dart';
import 'widget/manager_text_field.dart';
import 'widget/phone_text_field.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRepository = context.read<AppRepository>();
    return BlocProvider<SignUpCubit>(
      create: (_) => SignUpCubit(appRepository: appRepository),
      child: SignUpView(
        onSignUpSuccess: (club) {
          Navigator.pushReplacementNamed(context, '/registered',
              arguments: club);
        },
      ),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key, required this.onSignUpSuccess}) : super(key: key);
  final ValueChanged<AppDomain> onSignUpSuccess;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _releaseFocus(context),
      child: ExtendedScaffoldWidget(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: _SignUpForm(onSignUpSuccess: onSignUpSuccess),
            ),
          ],
        ),
      ),
    );
  }

  void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();
}

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({Key? key, required this.onSignUpSuccess})
      : super(key: key);
  final ValueChanged<AppDomain> onSignUpSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == SubmissionStatus.success) {
          ManagerDomain manager = state.toManagerDomain(SignUpState.id);
          ClubDomain club = state.toClubDomain();
          AppDomain appDomain = AppDomain(manager: manager, club: club);
          onSignUpSuccess(appDomain);
          return;
        }

        if (state.submissionStatus == SubmissionStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(GenericErrorSnackBar(
              text: 'Ошибка при вводе данных',
            ));
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            const HeaderWidget(),
           const SizedBox(height: 16),
           const ClubTextFiled(),
           const CountryTextField(),
           const CityTextField(),
           const ManagerTextField(),
           const BirthdayTextField(),
           const PhoneTextField(),
            // EmailTextField(),
            const SizedBox(
              height: 16,
            ),
            RegisterButton(onTap: () {
              context.read<SignUpCubit>().onSubmit();
            }),
          ],
        );
      },
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage(
            'assets/register/background.png',
          ),
        ),
      ),
      child: SvgPicture.asset('assets/register/logo.svg',
          height: 190,
          width: 70,
          alignment: Alignment.center,
          fit: BoxFit.scaleDown),
    );
  }
}
