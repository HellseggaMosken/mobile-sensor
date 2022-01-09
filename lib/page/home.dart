import 'package:flutter/material.dart';
import 'package:mobile_sensor/page/monitor.dart';
import 'package:mobile_sensor/page/setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: const [
          MonitorPage(),
          SettingPage(),
        ],
        index: _index,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: "Monitor",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
        showUnselectedLabels: true,
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
