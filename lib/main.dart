import 'package:flutter/material.dart';
import 'package:yelpexplorer/presentation/business_list_screen.dart';

void main() => runApp(YelpExplorer());

class YelpExplorer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red[700],
        accentColor: Colors.red[400],
      ),
      home: BusinessListScreen(),
    );
  }
}
