import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yelpexplorer/core/utils/const.dart' as Const;
import 'package:yelpexplorer/core/utils/injection.dart';
import 'package:yelpexplorer/core/utils/stars_provider.dart' as StarsProvider;
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/model/review.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_details_usecase.dart';
import 'package:yelpexplorer/features/business/domain/graphql/usecase/get_business_details_graphql_usecase.dart';
import 'package:yelpexplorer/features/business/domain/rest/usecase/get_business_details_rest_usecase.dart';

class BusinessDetailsScreen extends StatefulWidget {
  final String businessId;

  BusinessDetailsScreen(this.businessId);

  @override
  _BusinessDetailsScreenState createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  Business business;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getData();
  }

  void getData() async {
    // TODO
    GetBusinessDetailsUseCase getBusinessDetailsUseCase;
    if (Const.USE_GRAPHQL) {
      getBusinessDetailsUseCase = getIt<GetBusinessDetailsGraphQLUseCase>();
    } else {
      getBusinessDetailsUseCase = getIt<GetBusinessDetailsRestUseCase>();
    }

    Business business = await getBusinessDetailsUseCase.execute(
      businessId: widget.businessId,
    );
    setState(() {
      this.isLoading = false;
      this.business = business;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YelpExplorer-Flutter"),
      ),
      body: BusinessDetails(business, isLoading),
    );
  }
}

class BusinessDetails extends StatelessWidget {
  final Business business;
  final bool isLoading;
  final double photoSize = 200.0;
  final double loaderSize = 24.0;

  BusinessDetails(this.business, this.isLoading);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
          height: loaderSize,
          width: loaderSize,
        ),
      );
    } else {
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
                OpeningHours(business.hours),
                ReviewList(business.reviews),
              ],
            ),
          ],
        ),
      );
    }
  }
}

class BusinessInfo extends StatelessWidget {
  final Business business;
  final TextStyle textStyle = TextStyle(fontSize: 13.0);

  BusinessInfo(this.business);

  String getPriceAndCategories() {
    // DRY - there is the same function in the business list
    String separator;
    if (business.price.isNotEmpty && business.categories.length > 0) {
      separator = "\u0020\u0020\u2022\u0020\u0020";
    } else {
      separator = "";
    }
    return "${business.price}$separator${business.categories.join(", ")}";
  }

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
                image: StarsProvider.getRatingImage(business.rating),
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
              getPriceAndCategories(),
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
      final List<String> hoursOfDay = businessHours[i];

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
                Const.days[i],
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
                              image: StarsProvider.getRatingImage(review.rating),
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
