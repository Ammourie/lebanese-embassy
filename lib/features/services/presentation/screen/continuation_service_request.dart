// Import required Flutter and third-party packages
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

// Import local project files
import '../../../../core/routing/route_paths.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_success_dialog.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/dynamic_question_form.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../../service_locator.dart';
import '../../../account/data/remote/models/responses/get_field_model.dart';
import '../../../order/data/remote/models/responses/get_order_model.dart';
import '../../data/remote/models/params/create_order_service_params.dart';
import '../../data/remote/models/responses/get_service_model.dart';
import '../blocs/service_bloc.dart';
import 'book_appointment_widget.dart';
import 'connected_price_card.dart';
import 'order_preveiw_service_request.dart';

// Screen for handling continuation of service requests
class ContinuationServiceRequestScreen extends StatefulWidget {
  const ContinuationServiceRequestScreen({
    required this.serviceModelList,
    this.orderModel,
    required this.getServicesLoaded,
    this.isEdite = false,
    required this.selecteFamilyMember,
  });

  final ServiceModel? serviceModelList; // Service details
  final int selecteFamilyMember; // Selected family member index
  final bool isEdite; // Flag to indicate edit mode
  final OrderModel? orderModel; // Order details if in edit mode
  final GetServicesLoaded getServicesLoaded; // Loaded services data

  @override
  State<StatefulWidget> createState() => _ContinuationServiceRequestState();
}

class _ContinuationServiceRequestState
    extends State<ContinuationServiceRequestScreen> {
  // Form keys for validation
  final List<GlobalKey<FormState>> _formKeyList = [];
  final ServiceBloc _serviceBloc = ServiceBloc();

  // UI state flags
  bool isRtl = false; // Right-to-left text direction
  bool isContainQuestion = false; // Contains question in form
  int indexQuestion = -1; // Index of question in form
  bool showConnectedPrice = false; // Show connected price view
  bool shouldRebuild = false; // Flag to trigger rebuild
  bool shouldSaveOnline = false; // Flag for online saving
  bool shouldShowDialogConfirm = false; // Show confirmation dialog

  // Step tracking variables
  int activeStep = 0; // Current active step
  int activeStepLast = 0; // Last active step
  int fullStepNum = 0; // Total number of steps
  int reachedStep = 0; // Last reached step
  int upperBound = 5; // Maximum steps
  double progress = 0.2; // Progress indicator value
  Set<int> reachedSteps = <int>{0, 2, 4, 5}; // Completed steps
  List<String> stepName = []; // Names of steps

  // Data storage
  List<InfoData>? info = []; // Form information
  FilesModelDataList pikedFiles =
      FilesModelDataList(files: []); // Selected files
  List<GroupedField> listdataTmp = []; // Temporary grouped fields
  List<GroupedField> listdata1 = []; // Current grouped fields
  List<InfoData> lst1 = []; // Current form data

  @override
  void initState() {
    super.initState();
    _initParameters();
  }

  @override
  void dispose() {
    _serviceBloc.close();
    super.dispose();
  }

  // Initialize parameters and form data
  void _initParameters() {
    stepName = widget.serviceModelList?.groups ?? [];
    fullStepNum = stepName.length;

    // Adjust step count by removing main question steps
    for (int i = 0; i < widget.serviceModelList!.groups!.length; i++) {
      if (widget.serviceModelList!.groups![i].contains('السؤال الرئيسي')) {
        fullStepNum--;
      }
    }

    // Create form keys for each step
    for (int i = 0; i < fullStepNum; i++) {
      _formKeyList.add(GlobalKey<FormState>());
    }

    // Initialize temporary data list
    for (int i = 0; i < widget.serviceModelList!.groups!.length; i++) {
      listdataTmp.addAll(widget.serviceModelList!
              .groupedFields![widget.serviceModelList!.groups![i]] ??
          []);
    }
  }

  @override
  Widget build(BuildContext context) {
    isRtl = Provider.of<LocaleProvider>(context, listen: false).isRTL;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Styles.colorBackground,
        body: WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonSizes.vLargerSpace,
                      _buildHeader(),
                      CommonSizes.vSmallerSpace,
                      ..._buildPageContent(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build header with back button and title
  Widget _buildHeader() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (showConnectedPrice) {
              setState(() {
                showConnectedPrice = false;
                activeStep--;
              });
            } else {
              Navigator.of(context).pop();
            }
          },
          child: SizedBox(
            width: 20.w,
            child: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        Expanded(
          child: Container(
            child: showConnectedPrice
                ? _buildHeaderText('الرسوم المرتبطة')
                : _buildHeaderText(
                    isContainQuestion
                        ? widget.serviceModelList!.groups![activeStep + 1]
                        : widget.serviceModelList!.groups![activeStep],
                  ),
          ),
        ),
        SizedBox(width: 20.w)
      ],
    );
  }

  // Build header text with styling
  Widget _buildHeaderText(String text) {
    return CustomText(
      textAlign: TextAlign.center,
      alignmentGeometry: Alignment.center,
      text: text,
      style: Styles.w700TextStyle().copyWith(
        fontSize: 20.sp,
        color: Styles.colorText,
      ),
    );
  }

  // Build main page content based on state
  List<Widget> _buildPageContent() {
    return showConnectedPrice
        ? _buildConnectedPriceWidget()
        : [
            _buildInstructionText(),
            CommonSizes.vBigSpace,
            Expanded(child: buildGroup()),
          ];
  }

  // Build instruction text for form filling
  Widget _buildInstructionText() {
    return CustomText(
      text:
          'يرجى ملء جميع الحقول المطلوبة بدقة وتأكد من صحة المعلومات قبل التقديم.',
      style: Styles.w400TextStyle().copyWith(
        fontSize: 16.sp,
        color: Styles.colorText,
      ),
      alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
          ? Alignment.centerRight
          : Alignment.centerLeft,
      textAlign: Provider.of<LocaleProvider>(context).isRTL
          ? TextAlign.right
          : TextAlign.left,
    );
  }

  // Build connected price widget list
  List<Widget> _buildConnectedPriceWidget() {
    return [
      Expanded(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 20.w),
          shrinkWrap: true,
          itemBuilder: (context, index) => ConnectedPriceCard(
            serviceModel: widget
                .getServicesLoaded.getServiceEntity!.serviceModelList[index],
          ),
          separatorBuilder: (context, index) => CommonSizes.vBigSpace,
          itemCount: widget
              .getServicesLoaded.getServiceEntity!.serviceModelList.length,
        ),
      ),
      SizedBox(height: 20),
      _buildConfirmButton(),
      CommonSizes.vBigSpace,
    ];
  }

  // Build confirmation button
  Widget _buildConfirmButton() {
    return CustomButton(
      width: double.infinity,
      text: 'تأكيد',
      style: Styles.w700TextStyle().copyWith(
        fontSize: 16.sp,
        height: 24 / 16,
        color: Styles.colorTextWhite,
      ),
      raduis: 8.r,
      textAlign: TextAlign.center,
      color: Styles.colorPrimary,
      fillColor: Styles.colorPrimary,
      height: 54.h,
      alignmentDirectional: AlignmentDirectional.center,
      onPressed: _handleConfirmButtonPress,
    );
  }

  // Handle confirm button press based on conditions
  void _handleConfirmButtonPress() {
    if (widget.isEdite) {
      _navigateToBookAppointment(isEdit: true);
    } else if (!widget.serviceModelList!.need_date!) {
      _creatOrder();
    } else if (widget.serviceModelList!.need_date!) {
      _navigateToBookAppointment(isEdit: false);
    }
  }

  // Navigate to book appointment screen
  void _navigateToBookAppointment({required bool isEdit}) {
    Utils.pushNewScreenWithRouteSettings(
      context,
      screen: BookAppointmentScreen(
        isEdite: isEdit,
        createOrderServiceParamsBody: CreateOrderServiceParamsBody(
          info: info,
          id: isEdit ? widget.orderModel!.id ?? 0 : 0,
          client_id: sl<AppStateModel>().user!.data!.id ?? 0,
          date: isEdit
              ? DateTime.tryParse(widget.orderModel!.date ?? "")
              : DateTime.now(),
          file: pikedFiles,
          service_id: widget.serviceModelList!.id ?? 0,
        ),
      ),
      settings: RouteSettings(name: RoutePaths.BookAppointmentScreen),
    );
  }

  // Create new order
  void _creatOrder() {
    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      settings:
          RouteSettings(name: RoutePaths.OrderPreveiwServiceRequestScreen),
      screen: OrderPreveiwServiceRequestScreen(
        info: info,
        needDate: widget.serviceModelList!.need_date ?? false,
        client_id: sl<AppStateModel>().user!.data!.id ?? 0,
        date: DateTime.now(),
        file: pikedFiles,
        service_id: widget.serviceModelList!.id ?? 0,
        id: 0,
      ),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  // Build dynamic form group
  Widget buildGroup() {
    lst1 = [];
    listdata1 = [];

    try {
      _buildListData();

      if (listdata1.isEmpty) {
        listdata1.addAll(
          widget.serviceModelList!.groupedFields![
                  widget.serviceModelList!.groups![activeStep]] ??
              [],
        );
      }

      _handleEditMode();

      return DynamicQuestionFormPage(
        formKey: _formKeyList[activeStep],
        onValueSelected: (value) => pikedFiles = value,
        listdata: listdata1,
        callback: _handleFormCallback,
      );
    } catch (e) {
      print(e);
      return Container();
    }
  }

  // Build list data based on groups and questions
  void _buildListData() {
    for (int i = 0; i < widget.serviceModelList!.groups!.length; i++) {
      if (widget.serviceModelList!.groups![i].contains('سؤال')) {
        isContainQuestion = true;
        indexQuestion = i;
        if (activeStep == i) {
          listdata1.addAll(widget.serviceModelList!
                  .groupedFields![widget.serviceModelList!.groups![i]] ??
              []);
          listdata1.addAll(widget.serviceModelList!
                  .groupedFields![widget.serviceModelList!.groups![i + 1]] ??
              []);
        }
      } else {
        if (isContainQuestion && indexQuestion != -1) {
          if (i == activeStep + 1 && indexQuestion != i - 1) {
            listdata1.addAll(widget.serviceModelList!
                    .groupedFields![widget.serviceModelList!.groups![i]] ??
                []);
          }
        } else {
          if (i == activeStep) {
            listdata1.addAll(widget.serviceModelList!
                    .groupedFields![widget.serviceModelList!.groups![i]] ??
                []);
          }
        }
      }
    }
  }

  // Handle edit mode data population
  void _handleEditMode() {
    if (widget.isEdite) {
      for (int i = 0; i < listdata1.length; i++) {
        int index = lst1.indexWhere((e) => e.field_id == listdata1[i].id);
        if (index != -1) {
          listdata1[i].values = lst1[index].value;
        }
      }
    }
  }

  // Handle form callback after submission
  void _handleFormCallback() {
    try {
      _handleSpecialCases();

      if (!shouldShowDialogConfirm) {
        _processFormSubmission();
      }
    } catch (e) {
      print(e);
    }
  }

  // Handle special cases in form submission
  void _handleSpecialCases() {
    if (widget.serviceModelList!.groups![0] == 'طلب تأشيرة' &&
        listdata1.last.values == 'عند الوصول') {
      shouldShowDialogConfirm = true;
      _addInfoData();
      _showConfirmationDialog();
    } else {
      shouldShowDialogConfirm = false;
    }
  }

  // Process form submission and handle next steps
  void _processFormSubmission() {
    activeStepLast = activeStep;
    shouldRebuild = true;

    if (activeStep < fullStepNum) {
      activeStep++;
      _addInfoData();
    }

    if (activeStep == fullStepNum) {
      _handleFinalStep();
    }

    sl<AppStateModel>().setshouldUpdateWidget(true);
    setState(() {});
  }

  // Add form information to info list
  void _addInfoData() {
    for (int i = 0; i < listdata1.length; i++) {
      if (listdata1[i].values?.isNotEmpty ?? false) {
        info!.add(InfoData(
          name: listdata1[i].name,
          value: listdata1[i].values,
          group: listdata1[i].group,
          field_id: listdata1[i].id,
        ));
      }
    }
  }

  // Handle final step of form submission
  void _handleFinalStep() {
    String memberName = widget.selecteFamilyMember == -1
        ? sl<AppStateModel>().user!.data!.family!.groups.first
        : sl<AppStateModel>()
            .user!
            .data!
            .family!
            .groups[widget.selecteFamilyMember];

    List<InfoData> memberGroup = sl<AppStateModel>()
        .user!
        .data!
        .family!
        .info
        .where((e) => e.group!.compareTo(memberName) == 0)
        .toList();

    info!.addAll(memberGroup);

    if (widget.serviceModelList!.price!.compareTo('0') != 0) {
      showConnectedPrice = true;
    } else {
      activeStep--;
      _creatOrder();
    }
  }

  // Show confirmation dialog
  void _showConfirmationDialog() {
    showCustomDialogServeMessageDialog(
      context: context,
      message: '',
      callBack: () {
        Navigator.of(context).pop();
        _navigateToOrderPreview();
      },
    );
  }

  // Navigate to order preview screen
  void _navigateToOrderPreview() {
    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      settings:
          RouteSettings(name: RoutePaths.OrderPreveiwServiceRequestScreen),
      screen: OrderPreveiwServiceRequestScreen(
        info: info,
        needDate: widget.serviceModelList!.need_date ?? false,
        client_id: sl<AppStateModel>().user!.data!.id ?? 0,
        date: DateTime.now(),
        file: pikedFiles,
        service_id: widget.serviceModelList!.id ?? 0,
        id: 0,
      ),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
