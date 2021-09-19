part of 'business_list_bloc.dart';

@immutable
abstract class BusinessListEvent {
  const BusinessListEvent();
}

class GetBusinessList extends BusinessListEvent {
  final String term;
  final String location;
  final String sortBy;
  final int limit;

  GetBusinessList({
    required this.term,
    required this.location,
    required this.sortBy,
    required this.limit,
  });
}
