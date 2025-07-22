// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsumer_core/src/konsumer_base.dart';

typedef Builder<N, S> = Widget Function(BuildContext, N, S, WidgetRef);
typedef Listen<N, S> = void Function(BuildContext, N, S, WidgetRef);
typedef OnReady<N> = void Function(N);

class KonsumerCore<N extends AutoDisposeNotifier<S>, S> extends StatelessWidget {
  const KonsumerCore({
    super.key,
    required this.provider,
    required this.builder,
    this.onReady,
    this.listen,
  });

  final AutoDisposeNotifierProvider<N, S> provider;
  final Builder<N, S> builder;
  final Listen<N, S>? listen;
  final OnReady<N>? onReady;

  @override
  Widget build(BuildContext context) {
    return KonsumerBase(
      onReady: (ref) => onReady?.call(ref.read(provider.notifier)),
      builder: (ref) {
        final state = ref.watch(provider);
        final notifier = ref.read(provider.notifier);

        ref.listen(provider, (oldState, newState) {
          // Call [listen] only when state changes
          if (listen != null && oldState != newState) {
            listen!(context, notifier, state, ref);
          }
        });

        return builder(context, notifier, state, ref);
      },
    );
  }
}

class StickyKonsumerCore<N extends Notifier<S>, S> extends StatelessWidget {
  const StickyKonsumerCore({
    super.key,
    required this.provider,
    required this.builder,
    this.onReady,
    this.listen,
  });

  final NotifierProvider<N, S> provider;
  final Builder<N, S> builder;
  final Listen<N, S>? listen;
  final OnReady<N>? onReady;

  @override
  Widget build(BuildContext context) {
    return KonsumerBase(
      onReady: (ref) => onReady?.call(ref.read(provider.notifier)),
      builder: (ref) {
        final state = ref.watch(provider);
        final notifier = ref.read(provider.notifier);

        ref.listen(provider, (oldState, newState) {
          // Call [listen] only when state changes
          if (listen != null && oldState != newState) {
            listen!(context, notifier, state, ref);
          }
        });

        return builder(context, notifier, state, ref);
      },
    );
  }
}