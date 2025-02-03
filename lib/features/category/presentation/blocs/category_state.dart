part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {
  @override
  List<Object?> get props => [];
}

class GetCategorysLoaded extends CategoryState {
  final GetCategoryEntity? getCategoryEntity;

  GetCategorysLoaded({this.getCategoryEntity});

  @override
  List<Object> get props => [];
}


class CategoryError extends CategoryState {
  final String? message;

  CategoryError(this.message);

  @override
  List<Object?> get props => [];
}
