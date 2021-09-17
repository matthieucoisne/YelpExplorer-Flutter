import 'package:yelpexplorer/features/business/data/graphql/mapper/business_graphql_mapper.dart';
import 'package:yelpexplorer/features/business/data/graphql/model/business_graphql_model.dart';
import 'package:yelpexplorer/features/business/data/stub/datasource/local/business_stub_datasource.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/repository/business_repository.dart';

// For simplicity, the BusinessStubDataSource uses the GraphQL data and models
class BusinessStubRepository implements BusinessRepository {
  final BusinessStubDataSource localDataSource;

  BusinessStubRepository(this.localDataSource);

  @override
  Future<List<Business>> getBusinessList(String term, String location, String sortBy, int limit) async {
    BusinessListGraphQLModel response = await localDataSource.getBusinessList();
    return response.businesses.toDomainModel();
  }

  @override
  Future<Business> getBusinessDetailsWithReviews(String businessId) async {
    BusinessDetailsGraphQLModel response = await localDataSource.getBusinessDetails();
    return response.business.toDomainModel();
  }
}
