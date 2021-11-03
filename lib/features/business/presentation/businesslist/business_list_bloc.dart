import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_list_usecase.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_mapper.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_ui_model.dart';

part 'business_list_event.dart';
part 'business_list_state.dart';

class BusinessListBloc extends Bloc<BusinessListEvent, BusinessListState> {
  final GetBusinessListUseCase _businessListUseCase;

  BusinessListBloc(this._businessListUseCase) : super(BusinessListLoading());

  @override
  Stream<BusinessListState> mapEventToState(BusinessListEvent event) async* {
    if (event is GetBusinessList) {
      try {
        yield (BusinessListLoading());
        final businesses = await _businessListUseCase.execute(
          event.term,
          event.location,
          event.sortBy,
          event.limit,
        );
        yield (BusinessListSuccess(businesses.toUiModels()));
      } on Exception catch (e) {
        yield (BusinessListError(e.toString())); // TODO
      }
    }
  }
}
