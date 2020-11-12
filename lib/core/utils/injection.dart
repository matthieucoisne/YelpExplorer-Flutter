import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:yelpexplorer/core/utils/const.dart' as Const;
import 'package:yelpexplorer/features/business/data/graphql/datasource/remote/business_graphql_datasource.dart';
import 'package:yelpexplorer/features/business/data/graphql/repository/business_graphql_data_repository.dart';
import 'package:yelpexplorer/features/business/data/rest/datasource/remote/business_rest_datasource.dart';
import 'package:yelpexplorer/features/business/data/rest/repository/business_rest_data_repository.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_details_usecase.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_list_usecase.dart';
import 'package:yelpexplorer/features/business/domain/graphql/repository/business_graphql_repository.dart';
import 'package:yelpexplorer/features/business/domain/graphql/usecase/get_business_details_graphql_usecase.dart';
import 'package:yelpexplorer/features/business/domain/graphql/usecase/get_business_list_graphql_usecase.dart';
import 'package:yelpexplorer/features/business/domain/rest/repository/business_rest_repository.dart';
import 'package:yelpexplorer/features/business/domain/rest/usecase/get_business_details_rest_usecase.dart';
import 'package:yelpexplorer/features/business/domain/rest/usecase/get_business_list_rest_usecase.dart';
import 'package:yelpexplorer/features/business/presentation/businessdetails/business_details_cubit.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  Const.USE_GRAPHQL ? _setupGraphQL() : _setupRest();
}

void _setupGraphQL() {
  // BLoC/Cubit
  getIt.registerFactory(() {
    GetBusinessListUseCase getBusinessListUseCase = getIt<GetBusinessListGraphQLUseCase>();
    return BusinessListBloc(getBusinessListUseCase);
  });
  getIt.registerFactory(() {
    GetBusinessDetailsUseCase getBusinessDetailsUseCase = getIt<GetBusinessDetailsGraphQLUseCase>();
    return BusinessDetailsCubit(getBusinessDetailsUseCase);
  });

  // Use cases
  getIt.registerLazySingleton(() => GetBusinessListGraphQLUseCase(getIt()));
  getIt.registerLazySingleton(() => GetBusinessDetailsGraphQLUseCase(getIt()));

  // Repository
  getIt.registerLazySingleton<BusinessGraphQLRepository>(
    () => BusinessGraphQLDataRepository(getIt()),
  );

  // Data sources
  getIt.registerLazySingleton(() => BusinessGraphQLDataSource(getIt()));

  // Api client
  getIt.registerLazySingleton(() {
    final HttpLink httpLink = HttpLink(uri: Const.URL_GRAPHQL);
    final AuthLink authLink = AuthLink(getToken: () => "Bearer ${Const.API_KEY}");
    final Link link = authLink.concat(httpLink);
    final GraphQLClient graphQLClient = GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    );
    return graphQLClient;
  });
}

void _setupRest() {
  // BLoC/Cubit
  getIt.registerFactory(() {
    GetBusinessListUseCase getBusinessListUseCase = getIt<GetBusinessListRestUseCase>();
    return BusinessListBloc(getBusinessListUseCase);
  });
  getIt.registerFactory(() {
    GetBusinessDetailsUseCase getBusinessDetailsUseCase = getIt<GetBusinessDetailsRestUseCase>();
    return BusinessDetailsCubit(getBusinessDetailsUseCase);
  });

  // Use cases
  getIt.registerLazySingleton(() => GetBusinessListRestUseCase(getIt()));
  getIt.registerLazySingleton(() => GetBusinessDetailsRestUseCase(getIt()));

  // Repository
  getIt.registerLazySingleton<BusinessRestRepository>(
    () => BusinessRestDataRepository(getIt()),
  );

  // Data source
  getIt.registerLazySingleton(() => BusinessRestDataSource(getIt()));

  // Api client
  getIt.registerLazySingleton(() => http.Client());
}
