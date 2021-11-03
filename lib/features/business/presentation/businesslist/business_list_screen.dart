import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yelpexplorer/features/business/presentation/businessdetails/business_details_screen.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_bloc.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_ui_model.dart';
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
            ScaffoldMessenger.of(context).showSnackBar(
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
  final List<BusinessListUiModel> businesses;

  BusinessList(this.businesses);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => BusinessListItem(businesses[index]),
      itemCount: businesses.length,
    );
  }
}

class BusinessListItem extends StatelessWidget {
  final BusinessListUiModel business;
  final double cardHeight = 100.0;
  final TextStyle textStyle = TextStyle(fontSize: 11.0);

  BusinessListItem(this.business);

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
                  image: business.photoUrl,
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
                        business.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Row(
                        children: [
                          Image(
                            image: business.ratingImage,
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
                        business.priceAndCategories,
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
