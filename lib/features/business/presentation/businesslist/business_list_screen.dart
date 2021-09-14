import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yelpexplorer/core/utils/business_helper.dart' as BusinessHelper;
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/presentation/businessdetails/business_details_screen.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_bloc.dart';
import 'package:yelpexplorer/features/business/presentation/widget/screen_loader.dart';

class BusinessListScreen extends StatefulWidget {
  @override
  _BusinessListScreenState createState() => _BusinessListScreenState();
}

class _BusinessListScreenState extends State<BusinessListScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<BusinessListBloc>(context).add(
      GetBusinessList(
        term: "sushi",
        location: "montreal",
        sortBy: "rating",
        limit: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YelpExplorer-Flutter"),
      ),
      body: BlocConsumer<BusinessListBloc, BusinessListState>(
        listener: (context, state) {
          if (state is BusinessListError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is BusinessListLoading) {
            return ScreenLoader();
          } else if (state is BusinessListSuccess) {
            return BusinessList(state.businesses);
          } else {
            // Error - A Snackbar will be displayed
            return Container();
          }
        },
      ),
    );
  }
}

class BusinessList extends StatelessWidget {
  final List<Business> businessList;

  BusinessList(this.businessList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => BusinessListItem(businessList[index], index + 1),
      itemCount: businessList.length,
    );
  }
}

class BusinessListItem extends StatelessWidget {
  final Business business;
  final int index;
  final double cardHeight = 100.0;
  final TextStyle textStyle = TextStyle(fontSize: 11.0);

  BusinessListItem(this.business, this.index);

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusinessDetailsScreen(business.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: InkWell(
        onTap: () {
          _navigateToDetails(context);
        },
        child: Container(
          height: cardHeight,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  bottomLeft: Radius.circular(6.0),
                ),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: business.imageUrl,
                  width: cardHeight,
                  height: cardHeight,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, url, error) => Image(
                    image: AssetImage("assets/placeholder_business_list.png"),
                    width: cardHeight,
                    height: cardHeight,
                  ),
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
                        "$index. ${business.name.toUpperCase()}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Row(
                        children: [
                          Image(
                            image: BusinessHelper.getRatingImage(business.rating),
                            width: 82.0,
                            height: 14.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "${business.reviewCount} reviews", // TODO i18n
                              style: textStyle,
                            ),
                          )
                        ],
                      ),
                      Text(
                        BusinessHelper.formatPriceAndCategories(business.price, business.categories),
                        style: textStyle,
                      ),
                      Text(
                        business.address,
                        style: textStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
