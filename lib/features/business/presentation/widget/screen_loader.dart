import 'package:flutter/material.dart';

class ScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red[700]),
        ),
        height: 24.0,
        width: 24.0,
      ),
    );
  }
}
