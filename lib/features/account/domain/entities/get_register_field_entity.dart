import 'package:equatable/equatable.dart';

import '../../data/remote/models/responses/request_group_field.dart';
import '../../data/remote/models/responses/user_model.dart';

class GetRegisterFieldEntity  extends Equatable {
  late RequestGroupField? requestGroupField;

  GetRegisterFieldEntity({
    required this.requestGroupField,
  });

  @override
  List<Object?> get props => [requestGroupField];
}
