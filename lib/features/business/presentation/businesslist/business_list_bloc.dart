import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_list_usecase.dart';

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
        yield (BusinessListSuccess(businesses));
      } on Exception catch (e) {
        yield (BusinessListError("ERROR")); // TODO
      }
    }
  }
}
