import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_details_usecase.dart';

part 'business_details_state.dart';

class BusinessDetailsCubit extends Cubit<BusinessDetailsState> {
  final GetBusinessDetailsUseCase _businessDetailsUseCase;

  BusinessDetailsCubit(this._businessDetailsUseCase) : super(BusinessDetailsLoading());

  Future<void> getBusinessDetails({
    required String businessId,
  }) async {
    try {
      emit(BusinessDetailsLoading());
      final business = await _businessDetailsUseCase.execute(businessId);
      // TODO map to BusinessDetailsUIModel instead of using the domain model
      emit(BusinessDetailsSuccess(business));
    } on Exception catch (e) {
      emit(BusinessDetailsError(e.toString())); // TODO
    }
  }
}
