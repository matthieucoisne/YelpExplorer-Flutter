import 'package:yelpexplorer/features/business/data/graphql/datasource/remote/business_graphql_datasource.dart';
import 'package:yelpexplorer/features/business/data/graphql/mapper/business_graphql_mapper.dart';
import 'package:yelpexplorer/features/business/data/graphql/model/business_graphql_model.dart';
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/graphql/repository/business_graphql_repository.dart';

class BusinessGraphQLDataRepository implements BusinessGraphQLRepository {
  final BusinessGraphQLDataSource remoteDataSource;

  BusinessGraphQLDataRepository(this.remoteDataSource);

  @override
  Future<List<Business>> getBusinessList(String term, String location, String sortBy, int limit) async {
    // TODO add try/catch - return Resource<List<Business>>
    BusinessListGraphQLModel response = await remoteDataSource.getBusinessList(
      term,
      location,
      sortBy,
      limit,
    );
    return response.businesses.toDomainModel();
  }

  @override
  Future<Business> getBusinessDetails(String businessId) async {
    // TODO add try/catch - return Resource<Business>
    BusinessDetailsGraphQLModel response = await remoteDataSource.getBusinessDetails(businessId);
    return response.business.toDomainModel();
  }
}
