import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

class MProvider<T extends BlocBase> extends StatelessWidget {
  final T Function(BuildContext) create;
  final WidgetBuilder builder;

  const MProvider({
    Key? key,
    required this.create,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: create,
      child: Builder(builder: builder),
    );
  }
}

class MSelector<T, E> extends StatelessWidget {
  final Widget Function(BuildContext, E) builder;
  final E Function(T) selector;

  const MSelector({
    required this.builder,
    required this.selector,
  });

  @override
  Widget build(BuildContext context) {
    final value = context.select<T, E>(selector);
    return builder(context, value);
  }
}

class MSelector2<T, E, F> extends StatelessWidget {
  final Widget Function(BuildContext, E, F) builder;
  final E Function(T) selector1;
  final F Function(T) selector2;

  const MSelector2({
    required this.builder,
    required this.selector1,
    required this.selector2,
  });

  @override
  Widget build(BuildContext context) {
    final value = context.select<T, E>(selector1);
    final value2 = context.select<T, F>(selector2);

    return builder(context, value, value2);
  }
}
