import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/utils.dart';
import '../../../order/data/remote/models/responses/get_order_model.dart';
import '../../data/remote/models/params/get_service_params.dart';
import '../../data/remote/models/responses/get_service_model.dart';
import '../blocs/service_bloc.dart';
import '../screen/continuation_service_request.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CreateServiceRequestProvider extends ChangeNotifier {
  final BuildContext context;
  final String title;
  final bool isEdit;
  final OrderModel? orderModel;
  final int categoryId;

  final formKey = GlobalKey<FormBuilderState>();
  final _focusNode = FocusNode();
  final serviceBloc = ServiceBloc();

  bool isRtl = false;
  GetServicesLoaded? getServicesLoaded;
  int selectedServiceIndex = -1;
  int selectedFamilyMemberIndex = -1;
  ServiceModel? selectedServiceModel;

  CreateServiceRequestProvider({
    required this.context,
    required this.title,
    required this.categoryId,
    this.isEdit = false,
    this.orderModel,
  }) {
    _init();
  }

  void _init() {
    getServices();
  }

  void getServices() {
    serviceBloc.add(
      GetServicesEvent(
        getServiceParams: GetServiceParams(
          body: GetServiceParamsBody(categoryId: categoryId),
        ),
      ),
    );
  }

  @override
  void dispose() {
    serviceBloc.close();
    _focusNode.dispose();
    super.dispose();
  }

  void handleServiceSelection(int index) {
    selectedServiceIndex = index;
    selectedServiceModel = getServicesLoaded?.getServiceEntity?.serviceModelList[index];
    notifyListeners();
  }

  void handleContinuePressed() {
    if (selectedServiceIndex == -1) {
      Utils.showToast('Please choose type');
      return;
    }

    final selectedService = getServicesLoaded?.getServiceEntity?.serviceModelList[selectedServiceIndex];
    if (selectedService?.groups?.isEmpty ?? true) {
      Fluttertoast.showToast(msg: 'No fields added to this service');
      Utils.popNavigate(context, popsCount: 1);
      return;
    }

    navigateToContinuation(selectedService!);
  }

  void navigateToContinuation(ServiceModel service) {
    final screen = ContinuationServiceRequestScreen(
      serviceModelList: service,
      getServicesLoaded: getServicesLoaded!,
      isEdite: isEdit,
      orderModel: isEdit ? orderModel : null,
      selecteFamilyMember: selectedFamilyMemberIndex,
    );

    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      settings: RouteSettings(
        name: isEdit ? RoutePaths.CreateServiceRequestScreen : RoutePaths.ChooseRequestMemberScreen,
      ),
      screen: screen,
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  void onServicesLoaded(GetServicesLoaded state) {
    getServicesLoaded = state;
    if (isEdit) {
      selectedFamilyMemberIndex = -1;
      selectedServiceIndex = state.getServiceEntity?.serviceModelList
          .indexWhere((e) => e.id == orderModel?.service?.id) ??
          -1;
      selectedServiceModel = state.getServiceEntity?.serviceModelList[selectedServiceIndex];
    }
    notifyListeners();
  }
}
