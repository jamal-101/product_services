import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IdentityVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Identity Verification")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField(items: [DropdownMenuItem(child: Text("National ID"))], onChanged: (_) {}),
            Row(children: [Expanded(child: Placeholder(fallbackHeight: 100)), SizedBox(width: 10), Expanded(child: Placeholder(fallbackHeight: 100))]),
            ElevatedButton(onPressed: () {}, child: Text("Submit Verification")),
          ],
        ),
      ),
    );
  }
}