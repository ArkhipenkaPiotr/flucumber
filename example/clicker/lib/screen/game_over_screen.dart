import 'package:clicker/cubit/clicker_cubit.dart';
import 'package:clicker/cubit/clicker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameOverScreen extends StatelessWidget {
  static const screenKey = Key('GameOverScreen');

  final GameResultsClickerState state;

  const GameOverScreen({Key? key = screenKey, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text('Good job!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 32)),
              const Spacer(),
              Text(
                'Your result: ${state.clicks}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 32),
              Text('Best result: ${state.bestResult}',
                  style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    context.read<ClickerCubit>().startGame();
                  },
                  child: const Text('Restart')),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
