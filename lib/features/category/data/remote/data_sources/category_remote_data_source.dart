
import '../../../../../core/data_sources/remote_data_source.dart';
import '../models/params/get_category_params.dart';
import '../models/responses/get_category_model.dart';


abstract class ICategoryRemoteDataSource extends RemoteDataSource {
  Future<GetCategoryModel> getCategory(GetCategoryParams model);

}

class CategoryRemoteDataSource extends ICategoryRemoteDataSource {
  CategoryRemoteDataSource();

  @override
  Future<GetCategoryModel> getCategory(GetCategoryParams params) async {
    var res;

    res = await this.get(params, withToken: false);
    return Future.value(GetCategoryModel.fromJson(res));
  }

}
