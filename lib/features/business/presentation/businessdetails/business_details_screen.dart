import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yelpexplorer/core/utils/business_helper.dart' as BusinessHelper;
import 'package:yelpexplorer/core/utils/const.dart' as Const;
import 'package:yelpexplorer/core/utils/injection.dart' as injection;
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';
import 'package:yelpexplorer/features/business/presentation/businessdetails/business_details_cubit.dart';
import 'package:yelpexplorer/features/business/presentation/widget/screen_loader.dart';

class BusinessDetailsScreen extends StatefulWidget {
  final String _businessId;

  BusinessDetailsScreen(this._businessId);

  @override
  _BusinessDetailsScreenState createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  // Another way of doing it compared to the BusinessListScreen
  // Here I am using a cubit but could have used a BLoC
  // I could have used `BlocProvider.of<BusinessDetailsCubit>(context)` instead of using getIt
  // Only if the previous screen is pushing a route wrapped in a `BlocProvider`
  final BusinessDetailsCubit businessDetailsCubit = injection.getIt<BusinessDetailsCubit>();

  @override
  void initState() {
    super.initState();
    businessDetailsCubit.getBusinessDetails(businessId: widget._businessId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YelpExplorer-Flutter"),
      ),
      body: BlocProvider(
        create: (context) => businessDetailsCubit,
        child: BlocConsumer<BusinessDetailsCubit, BusinessDetailsState>(
          listener: (context, state) {
            if (state is BusinessDetailsError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is BusinessDetailsLoading) {
              return ScreenLoader();
            } else if (state is BusinessDetailsSuccess) {
              return BusinessDetails(state.business);
            } else {
              // Error - A Snackbar will be displayed
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class BusinessDetails extends StatelessWidget {
  final Business business;
  final double photoSize = 200.0;

  BusinessDetails(this.business);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: business.imageUrl,
            height: photoSize,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, url, error) => Image(
              image: AssetImage("assets/placeholder_business_details.png"),
              height: photoSize,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BusinessInfo(business),
              OpeningHours(business.hours), // TODO UiModel
              ReviewList(business.reviews), // TODO UiModel
            ],
          ),
        ],
      ),
    );
  }
}

class BusinessInfo extends StatelessWidget {
  final Business business;
  final TextStyle textStyle = TextStyle(fontSize: 13.0);

  BusinessInfo(this.business);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Text(
              business.name.toUpperCase(),
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
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
          Container(
            margin: EdgeInsets.only(top: 8.0),
            child: Text(
              BusinessHelper.formatPriceAndCategories(business.price, business.categories),
              style: textStyle,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0),
            child: Text(
              business.address,
              style: textStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class OpeningHours extends StatelessWidget {
  final Map<int, List<String>> businessHours;

  OpeningHours(this.businessHours);

  @override
  Widget build(BuildContext context) {
    final List<TableRow> tableRows = [];
    for (int i = 0; i < Const.days.length; i++) {
      final List<String>? hoursOfDay = businessHours[i];

      String hours;
      if (hoursOfDay != null) {
        hours = hoursOfDay.join("\n");
      } else {
        hours = "Closed";
      }

      tableRows.add(
        TableRow(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              child: Text(
                Const.days[i]!,
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16.0, top: 4.0),
              child: Text(hours, style: TextStyle(fontSize: 13.0)),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(8.0, 26.0, 8.0, 0.0),
          child: Text(
            "Opening Hours",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
          child: Table(
            defaultColumnWidth: IntrinsicColumnWidth(),
            children: tableRows,
          ),
        ),
      ],
    );
  }
}

class ReviewList extends StatelessWidget {
  final List<Review> reviews;

  ReviewList(this.reviews);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(8.0, 26.0, 8.0, 4.0),
          child: Text(
            "Latest reviews",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => ReviewListItem(reviews[index]),
          itemCount: reviews.length,
        ),
      ],
    );
  }
}

class ReviewListItem extends StatelessWidget {
  final Review review;
  final double userImageSize = 44.0;

  ReviewListItem(this.review);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(6.0, 4.0, 6.0, 8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: review.user.imageUrl,
                  width: userImageSize,
                  height: userImageSize,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, url, error) => Image(
                    image: AssetImage("assets/placeholder_user.png"),
                    width: userImageSize,
                    height: userImageSize,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.user.name,
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 6.0),
                        child: Row(
                          children: [
                            Image(
                              image: BusinessHelper.getRatingImage(review.rating),
                              width: 82.0,
                              height: 14.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.0),
                              child: Text(
                                review.timeCreated,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 8.0),
              child: Text(
                review.text,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
