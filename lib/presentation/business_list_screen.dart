import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yelpexplorer/data/repository/business_data_repository.dart';
import 'package:yelpexplorer/domain/model/business.dart';
import 'package:yelpexplorer/utils/stars_provider.dart' as StarsProvider;

class BusinessListScreen extends StatefulWidget {
  @override
  _BusinessListScreenState createState() => _BusinessListScreenState();
}

class _BusinessListScreenState extends State<BusinessListScreen> {
  List<Business> data = List();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getData();
  }

  void getData() async {
    var data = await BusinessDataRepository().getBusinessList();
    setState(() {
      isLoading = false;
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YelpExplorer-Flutter"),
      ),
      body: BusinessList(data, isLoading),
    );
  }
}

class BusinessList extends StatelessWidget {
  final List<Business> data;
  final bool isLoading;

  BusinessList(this.data, this.isLoading);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
          height: 24.0,
          width: 24.0,
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return BusinessListItem(data[index], index + 1);
        },
        itemCount: data.length,
      );
    }
  }
}

class BusinessListItem extends StatelessWidget {
  final Business business;
  final int index;
  final double cardHeight = 100.0;
  final TextStyle textStyle = TextStyle(fontSize: 11.0);

  BusinessListItem(this.business, this.index);

  String getPriceAndCategories() {
    String separator;
    if (business.price.isNotEmpty && business.categories.length > 0) {
      separator = "\u0020\u0020\u2022\u0020\u0020";
    } else {
      separator = "";
    }
    return "${business.price}$separator${business.categories.join(",")}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: InkWell(
        onTap: () => {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("${business.name}"),
          )),
        },
        child: Container(
          height: cardHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  bottomLeft: Radius.circular(6.0),
                ),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: business.photoUrl,
                  height: cardHeight,
                  width: cardHeight,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "$index. ${business.name}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Image(
                            image: StarsProvider.getRatingImage(business.rating),
                            width: 82.0,
                            height: 14.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "${business.reviewCount} reviews",
                              style: textStyle,
                            ),
                          )
                        ],
                      ),
                      Text(
                        getPriceAndCategories(),
                        style: textStyle,
                      ),
                      Text(
                        business.address,
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
