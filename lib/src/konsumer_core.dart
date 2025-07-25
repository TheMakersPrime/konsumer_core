// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsumer_core/src/konsumer_base.dart';
import 'package:konsumer_core/src/konsumer_pod.dart';

typedef KonsumerBuilder<N, S> = Widget Function(BuildContext, KonsumerPod<N, S>);
typedef KonsumerListen<N, S> = void Function(BuildContext, KonsumerPod<N, S>);
typedef KonsumerOnReady<N> = void Function(N);

class KonsumerCore<N extends AutoDisposeNotifier<S>, S> extends StatelessWidget {
  const KonsumerCore({
    super.key,
    required this.provider,
    required this.builder,
    this.onReady,
    this.listen,
  });

  final AutoDisposeNotifierProvider<N, S> provider;
  final KonsumerBuilder<N, S> builder;
  final KonsumerListen<N, S>? listen;
  final KonsumerOnReady<N>? onReady;

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
            listen!(context, KonsumerPod(notifier, newState, ref));
          }
        });

        return builder(context, KonsumerPod(notifier, state, ref));
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
  final KonsumerBuilder<N, S> builder;
  final KonsumerListen<N, S>? listen;
  final KonsumerOnReady<N>? onReady;

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
            listen!(context, KonsumerPod(notifier, newState, ref));
          }
        });

        return builder(context, KonsumerPod(notifier, state, ref));
      },
    );
  }
}
