part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class GetCategorysEvent extends CategoryEvent {
  final GetCategoryParams? getCategoryParams;

  GetCategorysEvent({this.getCategoryParams});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

