import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelpexplorer/core/utils/injection.dart' as injection;
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_bloc.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.setup();
  return runApp(YelpExplorer());
}

class YelpExplorer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red[700],
        accentColor: Colors.red[400],
      ),
      home: BlocProvider(
        create: (context) => injection.getIt<BusinessListBloc>(),
        child: BusinessListScreen(),
      ),
    );
  }
}
