part of '../businessdetails/business_details_cubit.dart';

@immutable
abstract class BusinessDetailsState extends Equatable {
  const BusinessDetailsState();

  @override
  List<Object> get props => [];
}

class BusinessDetailsLoading extends BusinessDetailsState {
  const BusinessDetailsLoading();

  @override
  List<Object> get props => [];
}

class BusinessDetailsSuccess extends BusinessDetailsState {
  final Business business;
  const BusinessDetailsSuccess(this.business);

  @override
  List<Object> get props => [business];
}

class BusinessDetailsError extends BusinessDetailsState {
  final String error;
  const BusinessDetailsError(this.error);

  @override
  List<Object> get props => [error];
}
