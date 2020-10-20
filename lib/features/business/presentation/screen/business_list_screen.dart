import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'package:yelpexplorer/core/utils/const.dart' as Const;
import 'package:yelpexplorer/core/utils/stars_provider.dart' as StarsProvider;
import 'package:yelpexplorer/features/business/data/graphql/datasource/remote/business_graphql_datasource.dart';
import 'package:yelpexplorer/features/business/data/graphql/repository/business_graphql_data_repository.dart';
import 'package:yelpexplorer/features/business/data/rest/datasource/remote/business_rest_datasource.dart';
import 'package:yelpexplorer/features/business/data/rest/repository/business_rest_data_repository.dart';
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_list_usecase.dart';
import 'package:yelpexplorer/features/business/domain/graphql/repository/business_graphql_repository.dart';
import 'package:yelpexplorer/features/business/domain/graphql/usecase/get_business_list_graphql_usecase.dart';
import 'package:yelpexplorer/features/business/domain/rest/repository/business_rest_repository.dart';
import 'package:yelpexplorer/features/business/domain/rest/usecase/get_business_list_rest_usecase.dart';
import 'package:yelpexplorer/features/business/presentation/screen/business_details_screen.dart';

class BusinessListScreen extends StatefulWidget {
  @override
  _BusinessListScreenState createState() => _BusinessListScreenState();
}

class _BusinessListScreenState extends State<BusinessListScreen> {
  List<Business> businesses;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getData();
  }

  void getData() async {
    // TODO manage this with DI
    bool rest = false;
    GetBusinessListUseCase getBusinessListUseCase;
    if (rest) {
      BusinessRestRepository repository = BusinessRestDataRepository(BusinessRestDataSource(http.Client()));
      getBusinessListUseCase = GetBusinessListRestUseCase(repository);
    } else {
      final HttpLink httpLink = HttpLink(uri: Const.URL_GRAPHQL);
      final AuthLink authLink = AuthLink(getToken: () => "Bearer ${Const.API_KEY}");
      final Link link = authLink.concat(httpLink);
      final GraphQLClient client = GraphQLClient(
        cache: InMemoryCache(),
        link: link,
      );

      BusinessGraphQLRepository repository = BusinessGraphQLDataRepository(BusinessGraphQLDataSource(client));
      getBusinessListUseCase = GetBusinessListGraphQLUseCase(repository);
    }

    List<Business> businesses = await getBusinessListUseCase.execute(
      term: "sushi",
      location: "montreal",
      sortBy: "rating",
      limit: 20,
    );
    setState(() {
      this.isLoading = false;
      this.businesses = businesses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YelpExplorer-Flutter"),
      ),
      body: BusinessList(businesses, isLoading),
    );
  }
}

class BusinessList extends StatelessWidget {
  final List<Business> businessList;
  final bool isLoading;
  final double loaderSize = 24.0;

  BusinessList(this.businessList, this.isLoading);

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
      return ListView.builder(
        itemBuilder: (context, index) => BusinessListItem(businessList[index], index + 1),
        itemCount: businessList.length,
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
    return "${business.price}$separator${business.categories.join(", ")}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusinessDetailsScreen(business.id),
            ),
          );
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
                      Text(
                        getPriceAndCategories(),
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
