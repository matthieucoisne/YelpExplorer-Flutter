import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:yelpexplorer/core/utils/const.dart' as Const;
import 'package:yelpexplorer/core/utils/network.dart' as Network;
import 'package:yelpexplorer/features/business/data/graphql/datasource/remote/business_graphql_datasource.dart';
import 'package:yelpexplorer/features/business/data/graphql/repository/business_graphql_repository.dart';
import 'package:yelpexplorer/features/business/data/rest/datasource/remote/business_rest_datasource.dart';
import 'package:yelpexplorer/features/business/data/rest/repository/business_rest_repository.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_details_usecase.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_list_usecase.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_details_usecase_impl.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_list_usecase_impl.dart';
import 'package:yelpexplorer/features/business/domain/repository/business_repository.dart';
import 'package:yelpexplorer/features/business/presentation/businessdetails/business_details_cubit.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_bloc.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  await _setupAppConfig();
  _setup();
  Const.USE_GRAPHQL ? _setupGraphQL() : _setupRest(); // TODO remove this check so we can switch data layer impl in settings
}

Future<void> _setupAppConfig() async {
  final String json = await rootBundle.loadString("config/app_config.json");
  final String apiKey = jsonDecode(json)["api_key"];
  getIt.registerSingleton(apiKey, instanceName: Const.NAMED_API_KEY);
}

void _setup() {
  // BLoC/Cubit
  getIt.registerFactory(() {
    GetBusinessListUseCase getBusinessListUseCase = getIt<GetBusinessListUseCaseImpl>();
    return BusinessListBloc(getBusinessListUseCase);
  });
  getIt.registerFactory(() {
    GetBusinessDetailsUseCase getBusinessDetailsUseCase = getIt<GetBusinessDetailsUseCaseImpl>();
    return BusinessDetailsCubit(getBusinessDetailsUseCase);
  });

  // Use Cases
  getIt.registerLazySingleton(() => GetBusinessListUseCaseImpl(getIt()));
  getIt.registerLazySingleton(() => GetBusinessDetailsUseCaseImpl(getIt()));

  // Http Client
  getIt.registerLazySingleton(() => Network.YelpHttpClient());
}

void _setupGraphQL() {
  // Repository
  getIt.registerLazySingleton<BusinessRepository>(
    () => BusinessGraphQLRepository(getIt()),
  );

  // Data Sources
  getIt.registerLazySingleton(() => BusinessGraphQLDataSource(getIt()));

  // GraphQL Client
  getIt.registerLazySingleton(() => Network.getGraphQLClient(getIt()));
}

void _setupRest() {
  // Repository
  getIt.registerLazySingleton<BusinessRepository>(
    () => BusinessRestRepository(getIt()),
  );

  // Data Source
  getIt.registerLazySingleton(() => BusinessRestDataSource(getIt()));
}
