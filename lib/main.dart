import 'package:flutter/material.dart';
import 'package:yelpexplorer/presentation/business_list_page.dart';

void main() {
  runApp(YelpExplorer());
}

class YelpExplorer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BusinessListPage(),
    );
  }
}
