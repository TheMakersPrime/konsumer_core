// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KonsumerBase extends ConsumerStatefulWidget {
  const KonsumerBase({
    required this.onReady,
    required this.builder,
  });

  final void Function(WidgetRef) onReady;
  final Widget Function(WidgetRef) builder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KonsumerBaseState();
}

class _KonsumerBaseState extends ConsumerState<KonsumerBase> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      widget.onReady(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(ref);
  }
}
