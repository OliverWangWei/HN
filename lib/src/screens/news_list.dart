import 'package:flutter/material.dart';

class NewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: Center(
        child: Text('Show some news here!'),
      ),
    );
  }
}
