import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignalGraph extends StatefulWidget {
  final Stream<double> signal;
  final int count; // Point counts in a graph
  final String name;

  const SignalGraph({
    Key? key,
    required this.name,
    required this.signal,
    this.count = 100,
  }) : super(key: key);

  @override
  _SignalGraphState createState() => _SignalGraphState();
}

class _SignalGraphState extends State<SignalGraph> {
  late final ListQueue<double> queue;

  @override
  void initState() {
    super.initState();
    queue = ListQueue<double>(widget.count);
    queue.add(0);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.signal,
      builder: (ctx, shot) {
        if (shot.hasData) {
          queue.add(shot.data as double);
          if (queue.length > widget.count) {
            queue.take(1);
          }
        } else if (shot.hasError) {
          if (kDebugMode) {
            print(shot.error);
          }
        }
        return Text(
          queue.last.toString(),
          style: const TextStyle(fontSize: 30),
        );
      },
    );
  }
}
