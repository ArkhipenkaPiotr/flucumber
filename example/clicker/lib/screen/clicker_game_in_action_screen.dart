import 'dart:async';

import 'package:clicker/cubit/clicker_cubit.dart';
import 'package:clicker/cubit/clicker_state.dart';
import 'package:clicker/model/game_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClickerGameInActionScreen extends StatefulWidget {
  @visibleForTesting
  static const contentKey = Key('ClickerGameInActionScreen');

  final GameInActionClickerState state;

  const ClickerGameInActionScreen({Key? key = contentKey, required this.state}) : super(key: key);

  @override
  State<ClickerGameInActionScreen> createState() => _ClickerGameInActionScreenState();
}

class _ClickerGameInActionScreenState extends State<ClickerGameInActionScreen> {
  static const _tickPeriodMillis = 1;
  static const _timeOutMillis = 15 * 1000;

  late final Timer _timer;

  var _timeLeft = '';

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: _tickPeriodMillis), (timer) {
      _updateTime(timer.tick);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Expanded(
                flex: 1,
                child: Text(
                  _getTitleByProgress(widget.state.progress),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const Spacer(),
              Text(
                _timeLeft,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 42),
              ),
              Text('Clicks: ${widget.state.clicks}'),
              const Spacer(),
              _ClickSpace(onClick: () {
                context.read<ClickerCubit>().processClick();
              }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _updateTime(int ticks) {
    final timeLeftMillis = ticks * _tickPeriodMillis;

    if (timeLeftMillis >= _timeOutMillis) {
      _timer.cancel();
      context.read<ClickerCubit>().onGameTimeout();
      return;
    }

    final seconds = timeLeftMillis ~/ 1000;
    final millis = (timeLeftMillis % 1000).toString().padRight(3, '0');

    setState(() {
      _timeLeft = '$seconds.$millis';
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  String _getTitleByProgress(GameProgress progress) {
    switch (progress) {
      case GameProgress.low:
        return 'Faster!';
      case GameProgress.medium:
        return 'More faster!';
      case GameProgress.good:
        return 'Good work!';
      case GameProgress.excellent:
        return 'MONSTER! ARE YOU A BOT??';
    }
  }
}

class _ClickSpace extends StatelessWidget {
  final VoidCallback onClick;

  const _ClickSpace({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color: Theme.of(context).primaryColorDark, width: 10),
          shape: BoxShape.circle,
        ),
        child: Center(
            child: Text(
          'Click!',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
        )),
      ),
    );
  }
}
