import 'package:flutter/material.dart';
import 'package:yelpexplorer/data/repository/BusinessDataRepository.dart';

class BusinessListPage extends StatefulWidget {
  @override
  _BusinessListPageState createState() => _BusinessListPageState();
}

class _BusinessListPageState extends State<BusinessListPage> {
  List<String> data = List();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var json = await BusinessDataRepository().getBusinessList();
    List<String> data = [];
    for (var business in json["businesses"]) {
      data.add(business["name"]);
    }
    setState(() {
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YelpExplorer'),
      ),
      body: Container(
        child: BusinessList(data),
      ),
    );
  }
}

class BusinessList extends StatelessWidget {
  final List<String> data;
  BusinessList(this.data);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Text(
          data[index],
          style: TextStyle(color: Colors.black),
        );
      },
      itemCount: data.length,
    );
  }
}