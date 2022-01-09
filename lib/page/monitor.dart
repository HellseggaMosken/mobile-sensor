import 'package:flutter/material.dart';
import 'package:mobile_sensor/sensor/gnss.dart';
import 'package:mobile_sensor/widget/signal_graph.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MonitorPage extends StatefulWidget {
  const MonitorPage({Key? key}) : super(key: key);

  @override
  _MonitorPageState createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  final List<Widget> _children = [
    SignalGraph(
      name: "Acc X",
      signal: userAccelerometerEvents.map((e) => e.x),
    ),
    SignalGraph(
      name: "Acc X",
      signal: accelerometerEvents.map((e) => e.z),
    ),
    SignalGraph(
      name: "Acc Y",
      signal: userAccelerometerEvents.map((e) => e.y),
    ),
    SignalGraph(
      name: "Acc Z",
      signal: userAccelerometerEvents.map((e) => e.z),
    ),
  ];

  final GNSS gnss = GNSS();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GNSS.initGnssSensor(),
        builder: (ctx, shot) {
          if (shot.hasData && (shot.data as bool)) {
            _children.addAll([
              SignalGraph(
                name: "GNSS Latitude",
                signal: gnss.latitude(),
              ),
              SignalGraph(
                name: "GNSS Longitude",
                signal: gnss.longitude(),
              ),
              SignalGraph(
                name: "GNSS Altitude",
                signal: gnss.altitude(),
              ),
            ]);
          }
          return ListView(children: _children);
        },
      ),
    );
  }
}
