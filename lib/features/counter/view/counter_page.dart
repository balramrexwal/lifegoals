import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lifegoals/core/navigation.dart';
import 'package:lifegoals/domain/authentication/authenticated_user.dart';
import 'package:lifegoals/features/authentication/bloc/authentication_bloc.dart';
import 'package:lifegoals/features/authentication/bloc/authentication_state.dart';
import 'package:lifegoals/features/counter/cubit/counter_cubit.dart';
import 'package:lifegoals/l10n/l10n.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: const Center(child: CounterText()),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            heroTag: 'increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.go(Routes.scanner),
            heroTag: 'scanner',
            child: const Icon(Icons.camera),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.go(Routes.todos),
            heroTag: 'todos',
            child: const Icon(Icons.task),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.go(Routes.about),
            heroTag: 'about',
            child: const Icon(Icons.info),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.go(Routes.login),
            heroTag: 'login',
            child: const Icon(Icons.login),
          ),
          const SizedBox(height: 8),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) => state.maybeWhen(
              authenticated: (AuthenticatedUser user) => FloatingActionButton(
                onPressed: () => context.go(Routes.profile),
                heroTag: 'profile',
                child: const Icon(Icons.verified_user),
              ),
              orElse: () => const SizedBox(height: 8),
            ),
          ),
        ],
      ),
      //),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayLarge);
  }
}
