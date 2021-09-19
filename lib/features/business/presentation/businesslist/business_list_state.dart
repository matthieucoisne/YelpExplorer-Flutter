part of 'business_list_bloc.dart';

@immutable
abstract class BusinessListState extends Equatable {
  const BusinessListState();
}

class BusinessListLoading extends BusinessListState {
  const BusinessListLoading();

  @override
  List<Object> get props => [];
}

class BusinessListSuccess extends BusinessListState {
  final List<BusinessListUiModel> businesses;

  const BusinessListSuccess(this.businesses);

  @override
  List<Object> get props => [businesses];
}

class BusinessListError extends BusinessListState {
  final String error;

  const BusinessListError(this.error);

  @override
  List<Object> get props => [error];
}
