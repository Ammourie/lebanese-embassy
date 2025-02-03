import 'package:equatable/equatable.dart';

import '../../data/remote/models/responses/get_category_model.dart';



class GetCategoryEntity extends Equatable {
  late List<CategoryModel> categoryModelList;

  GetCategoryEntity({
    required this.categoryModelList,
  });

  @override
  List<Object?> get props => [categoryModelList];
}
