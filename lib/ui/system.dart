import 'package:flutter/material.dart';

class System extends StatefulWidget {
  const System({Key? key}) : super(key: key);

  @override
  State<System> createState() => _SystemState();
}

class _SystemState extends State<System> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("体系"),
      ),
      body: Center(
        child: Text("体系"),
      ),
    );
  }
}
