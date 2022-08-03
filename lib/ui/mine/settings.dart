import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("设置"),
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: colum(),
    );
  }

  Widget colum() {
    return Column(
      children: [
        SizedBox(height: 10.0,),
        InkWell(child: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Row(
            children: [
              Icon(Icons.language),
              SizedBox(width: 20.0,),
              Expanded(child: Text("多语言", style: TextStyle(fontSize: 18.0, color: Colors.black),),),
              Text("跟随系统", style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),),
              Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
        ), onTap: () {

        },),
        SizedBox(height: 10.0,),
        InkWell(child: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Row(
            children: [
              Icon(Icons.update),
              SizedBox(width: 20.0,),
              Expanded(child: Text("检查更新", style: TextStyle(fontSize: 18.0, color: Colors.black),),),
              Icon(Icons.keyboard_arrow_right,),
            ],
          ),
        ), onTap: () {

        },),
      ],
    );
  }
}
