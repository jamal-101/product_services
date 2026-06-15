import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification Settings")),
      body: ListView(
        children: [
          SwitchListTile(title: Text("Email Alerts"), value: true, onChanged: (v) {}),
          SwitchListTile(title: Text("Push Notifications"), value: true, onChanged: (v) {}),
        ],
      ),
    );
  }
}