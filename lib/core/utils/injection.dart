import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:yelpexplorer/core/utils/const.dart' as Const;
import 'package:yelpexplorer/core/utils/network.dart' as Network;
import 'package:yelpexplorer/features/business/data/graphql/datasource/remote/business_graphql_datasource.dart';
import 'package:yelpexplorer/features/business/data/graphql/repository/business_graphql_repository.dart';
import 'package:yelpexplorer/features/business/data/rest/datasource/remote/business_rest_datasource.dart';
import 'package:yelpexplorer/features/business/data/rest/repository/business_rest_repository.dart';
import 'package:yelpexplorer/features/business/data/stub/datasource/local/business_stub_datasource.dart';
import 'package:yelpexplorer/features/business/data/stub/datasource/repository/business_stub_repository.dart';
import 'package:yelpexplorer/features/business/domain/repository/business_repository.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_details_usecase.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_list_usecase.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_details_usecase_impl.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_list_usecase_impl.dart';
import 'package:yelpexplorer/features/business/presentation/businessdetails/business_details_cubit.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_bloc.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  await _setupAppConfig();

  switch (Const.DATA_LAYER) {
    case Const.DataLayer.rest:
      _setupRest();
      break;
    case Const.DataLayer.graphql:
      _setupGraphQL();
      break;
    case Const.DataLayer.stub:
      _setupStub();
      break;
  }
}

Future<void> _setupAppConfig() async {
  // API Key
  final String json = await rootBundle.loadString("config/app_config.json");
  final String apiKey = jsonDecode(json)["api_key"];
  getIt.registerSingleton<String>(apiKey, instanceName: Const.NAMED_API_KEY);

  // BLoC/Cubit
  getIt.registerFactory<BusinessListBloc>(() {
    GetBusinessListUseCase getBusinessListUseCase = getIt<GetBusinessListUseCase>();
    return BusinessListBloc(getBusinessListUseCase);
  });
  getIt.registerFactory<BusinessDetailsCubit>(() {
    GetBusinessDetailsUseCase getBusinessDetailsUseCase = getIt<GetBusinessDetailsUseCase>();
    return BusinessDetailsCubit(getBusinessDetailsUseCase);
  });

  // Use Cases
  getIt.registerLazySingleton<GetBusinessListUseCase>(() => GetBusinessListUseCaseImpl(getIt()));
  getIt.registerLazySingleton<GetBusinessDetailsUseCase>(() => GetBusinessDetailsUseCaseImpl(getIt()));

  // HTTP Client - used by both REST/GraphQL
  getIt.registerLazySingleton<Network.YelpHttpClient>(() => Network.YelpHttpClient());
}

void _setupGraphQL() {
  // GraphQL Client
  getIt.registerLazySingleton<GraphQLClient>(() => Network.getGraphQLClient(getIt()));

  // Repository
  getIt.registerLazySingleton<BusinessRepository>(() => BusinessGraphQLRepository(getIt()));

  // Data Sources
  getIt.registerLazySingleton<BusinessGraphQLDataSource>(() => BusinessGraphQLDataSource(getIt()));
}

void _setupRest() {
  // Repository
  getIt.registerLazySingleton<BusinessRepository>(() => BusinessRestRepository(getIt()));

  // Data Source
  getIt.registerLazySingleton<BusinessRestDataSource>(() => BusinessRestDataSource(getIt()));
}

void _setupStub() {
  // Repository
  getIt.registerLazySingleton<BusinessRepository>(() => BusinessStubRepository(getIt()));

  // Data Source
  getIt.registerLazySingleton<BusinessStubDataSource>(() => BusinessStubDataSource());
}
