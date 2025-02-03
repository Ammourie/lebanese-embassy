import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../service_locator.dart';
import '../../data/remote/models/params/get_category_params.dart';
import '../../data/repositories/category_repository.dart';
import '../../domain/entities/get_category_entity.dart';
import '../../domain/use_cases/get_category_use_case.dart';


part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<GetCategorysEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        var res = await GetCategoryUseCase(sl<CategoryRepository>())
            .call(event.getCategoryParams!);

        emit(res.fold((l) => CategoryError(l.errorMessage), (r) {
          return GetCategorysLoaded(getCategoryEntity: r);
        }));
      } catch (e) {}
    });
    }
}
