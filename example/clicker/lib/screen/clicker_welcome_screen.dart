import 'package:clicker/cubit/clicker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClickerWelcomeScreen extends StatelessWidget {
  @visibleForTesting
  static const screenKey = Key('ClickerWelcomeScreen');

  @visibleForTesting
  static const startGameKey = Key('ClickerWelcomeScreen.startGama');

  const ClickerWelcomeScreen({Key? key = screenKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            Text(
              'Welcome to clicker game!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            Text(
              'Click button to start',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
                key: startGameKey,
                onPressed: () {
                  context.read<ClickerCubit>().startGame();
                },
                child: const Text('Start!')),
            const Spacer(flex: 3),
          ],
        ),
      ),
    ));
  }
}
