import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:yelpexplorer/core/utils/network.dart';
import 'package:yelpexplorer/features/business/data/graphql/model/business_graphql_model.dart';

class BusinessGraphQLDataSource {
  final GraphQLClient client;

  BusinessGraphQLDataSource(this.client);

  Future<BusinessListGraphQLModel> getBusinessList(String term, String location, String sortBy, int limit) async {
    // TODO add try/catch
    final QueryResult queryResult = await client.getData(QueryOptions(
      document: Queries.businessListQuery,
      variables: {
        "term": term,
        "location": location,
        "sortBy": sortBy,
        "limit": limit,
      },
    ));
    final Map<String, dynamic> json = queryResult.data!;
    return BusinessListGraphQLModel.fromJson(json);
  }

  Future<BusinessDetailsGraphQLModel> getBusinessDetails(String businessId) async {
    // TODO add try/catch
    final QueryResult queryResult = await client.getData(QueryOptions(
      document: Queries.businessDetailsQuery,
      variables: {
        "id": businessId,
      },
    ));
    final Map<String, dynamic> json = queryResult.data!;
    return BusinessDetailsGraphQLModel.fromJson(json);
  }
}

@visibleForTesting
class Queries {
  static final businessListQuery = gql("""
    query BusinessList(\$term: String, \$location: String!, \$sortBy: String, \$limit:Int) {
      search(term: \$term, location: \$location, sort_by: \$sortBy, limit: \$limit) {
        total
        business {
          id
          name
          photos
          rating
          review_count
          location {
            address1
            city
          }
          price
          categories {
            title
          }
        }
      }
    }
    """);

  static final businessDetailsQuery = gql("""
    query BusinessDetails(\$id: String!) {
      business(id: \$id) {
        id
        name
        photos
        rating
        review_count
        location {
          address1
          city
        }
        price
        categories {
          title
        }
        display_phone
        hours {
          open {
            day
            start
            end
          }
        }
        reviews {
          user {
            name
            image_url
          }
          text
          rating
          time_created
        }
      }
    }
    """);
}
