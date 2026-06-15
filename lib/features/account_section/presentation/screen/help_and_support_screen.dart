import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpAndSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Help & Support")),
      body: Column(
        children: [
          ExpansionTile(title: Text("Can I buy products directly?")),
          ExpansionTile(title: Text("How do I contact a seller?")),
          Spacer(),
          Container(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(onPressed: () {}, child: Text("Contact Support")),
          ),
        ],
      ),
    );
  }
}