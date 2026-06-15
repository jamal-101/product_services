import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change Password")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: "Current Password")),
            TextField(decoration: InputDecoration(labelText: "New Password")),
            TextField(decoration: InputDecoration(labelText: "Confirm New Password")),
            ElevatedButton(onPressed: () {}, child: Text("Save Changes")),
          ],
        ),
      ),
    );
  }
}