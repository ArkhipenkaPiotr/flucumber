import 'package:clicker/cubit/clicker_cubit.dart';
import 'package:clicker/cubit/clicker_state.dart';
import 'package:clicker/screen/clicker_game_in_action_screen.dart';
import 'package:clicker/screen/clicker_welcome_screen.dart';
import 'package:clicker/screen/game_over_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClickerScreen extends StatefulWidget {
  const ClickerScreen({Key? key}) : super(key: key);

  @override
  State<ClickerScreen> createState() => _ClickerScreenState();
}

class _ClickerScreenState extends State<ClickerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClickerCubit>(
        create: (context) => ClickerCubit(),
        child: BlocBuilder<ClickerCubit, ClickerState>(builder: (context, state) {
          if (state is GameInActionClickerState) {
            return ClickerGameInActionScreen(state: state);
          }

          if (state is GameResultsClickerState) {
            return GameOverScreen(
              state: state,
            );
          }

          return const ClickerWelcomeScreen();
        }));
  }
}
