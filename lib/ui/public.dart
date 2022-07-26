import 'package:flutter/material.dart';

class Public extends StatefulWidget {
  const Public({Key? key}) : super(key: key);

  @override
  State<Public> createState() => _PublicState();
}

class _PublicState extends State<Public> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("公众号"),
      ),
      body: Center(
        child: Text("公众号"),
      ),
    );
  }
}
