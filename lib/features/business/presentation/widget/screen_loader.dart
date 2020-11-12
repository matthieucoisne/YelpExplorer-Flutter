import 'package:flutter/material.dart';

class ScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: CircularProgressIndicator(),
        height: 24.0,
        width: 24.0,
      ),
    );
  }
}
