import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_details_usecase.dart';

part 'business_details_state.dart';

class BusinessDetailsCubit extends Cubit<BusinessDetailsState> {
  final GetBusinessDetailsUseCase _businessDetailsUseCase;

  BusinessDetailsCubit(this._businessDetailsUseCase) : super(BusinessDetailsLoading());

  Future<void> getBusinessDetails({
    @required String businessId,
  }) async {
    try {
      emit(BusinessDetailsLoading());
      final businesses = await _businessDetailsUseCase.execute(businessId);
      emit(BusinessDetailsSuccess(businesses));
    } on Exception catch (e) {
      emit(BusinessDetailsError(e.toString())); // TODO
    }
  }
}
