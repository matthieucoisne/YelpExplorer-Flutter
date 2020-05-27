import 'package:flutter/material.dart';
import 'package:yelpexplorer/data/repository/BusinessDataRepository.dart';
import 'package:yelpexplorer/domain/model/business.dart';

class BusinessListPage extends StatefulWidget {
  @override
  _BusinessListPageState createState() => _BusinessListPageState();
}

class _BusinessListPageState extends State<BusinessListPage> {
  List<Business> data = List();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var data = await BusinessDataRepository().getBusinessList();
    setState(() {
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('YelpExplorer')),
      body: BusinessList(data),
    );
  }
}

class BusinessList extends StatelessWidget {
  final List<Business> data;

  BusinessList(this.data);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => BusinessListItem(data[index]),
      itemCount: data.length,
    );
  }
}

class BusinessListItem extends StatelessWidget {
  final Business business;

  BusinessListItem(this.business);

  @override
  Widget build(BuildContext context) {
    return Text(
      business.name,
      style: TextStyle(color: Colors.black),
    );
  }
}
