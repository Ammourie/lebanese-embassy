import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/create_service_request_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../core/widget/waiting_widget.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../order/data/remote/models/responses/get_order_model.dart';
import '../blocs/service_bloc.dart';

class CreateServiceRequestScreen extends StatelessWidget {
  const CreateServiceRequestScreen({
    required this.title,
    this.isEdit = false,
    this.orderModel,
    required this.categoryId,
  });

  final String title;
  final OrderModel? orderModel;
  final int categoryId;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateServiceRequestProvider(
        context: context,
        title: title,
        categoryId: categoryId,
        isEdit: isEdit,
        orderModel: orderModel,
      ),
      child: _CreateServiceRequestContent(),
    );
  }
}

class _CreateServiceRequestContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CreateServiceRequestProvider>(context);
    provider.isRtl = Provider.of<LocaleProvider>(context, listen: false).isRTL;

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
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _buildServiceBloc(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceBloc() {
    return Consumer<CreateServiceRequestProvider>(
        builder: (context, provider, _) {
      return BlocConsumer<ServiceBloc, ServiceState>(
        bloc: provider.serviceBloc,
        listener: (context, state) {
          if (state is GetServicesLoaded) {
            provider.onServicesLoaded(state);
          }
        },
        builder: (context, state) {
          if (state is ServiceLoading) {
            return WaitingWidget();
          }
          if (state is ServiceError) {
            return ErrorWidgetScreen(
              callBack: provider.getServices,
              message: state.message ?? "",
              height: 250.h,
              width: 250.w,
            );
          }
          if (provider.getServicesLoaded == null) {
            return Container();
          }
          return _buildMainContent();
        },
      );
    });
  }

  Widget _buildMainContent() {
    return Consumer<CreateServiceRequestProvider>(
        builder: (context, provider, _) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonSizes.vLargerSpace,
          _buildHeader(),
          CommonSizes.vSmallerSpace,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildServiceTypeSection(),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildContinueButton(),
          CommonSizes.vBigSpace,
        ],
      );
    });
  }

  Widget _buildHeader() {
    return Consumer<CreateServiceRequestProvider>(
        builder: (context, provider, _) {
      return Row(
        children: [
          InkWell(
            onTap: () => Utils.popNavigate(context, popsCount: 1),
            child: SizedBox(
              width: 20.w,
              child: Icon(Icons.arrow_back_ios_new),
            ),
          ),
          Expanded(
            child: CustomText(
              textAlign: TextAlign.center,
              alignmentGeometry: Alignment.center,
              text: provider.title,
              style: Styles.w700TextStyle().copyWith(
                fontSize: 24.sp,
                color: Styles.colorText,
              ),
            ),
          ),
          SizedBox(width: 20.w),
        ],
      );
    });
  }

  Widget _buildServiceTypeSection() {
    return Consumer<CreateServiceRequestProvider>(
        builder: (context, provider, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'نوع الطلب:',
            style: Styles.w700TextStyle().copyWith(
              fontSize: 16.sp,
              color: Styles.colorText,
            ),
            alignmentGeometry:
                provider.isRtl ? Alignment.centerRight : Alignment.centerLeft,
            textAlign: provider.isRtl ? TextAlign.right : TextAlign.left,
          ),
          CommonSizes.vSmallestSpace,
          _buildServiceTypeChips(),
          CommonSizes.vSmallerSpace,
        ],
      );
    });
  }

  Widget _buildServiceTypeChips() {
    return Consumer<CreateServiceRequestProvider>(
        builder: (context, provider, _) {
      final services =
          provider.getServicesLoaded?.getServiceEntity?.serviceModelList ?? [];
      return ChipList(
        listOfChipNames: services.map((s) => s.name ?? '').toList(),
        activeTextColorList: [Styles.colorTextWhite],
        activeBgColorList: [Styles.colorPrimary],
        checkmarkColor: Styles.colorTextWhite,
        showCheckmark: false,
        inactiveBgColorList: [Styles.colorbtnGray.withOpacity(0.5)],
        shouldWrap: true,
        style: Styles.w700TextStyle().copyWith(
          color: Styles.colorTextWhite,
          fontSize: 16.sp,
        ),
        runSpacing: 8.w,
        spacing: 8.w,
        inactiveTextColorList: [Styles.colorIconInActive],
        listOfChipIndicesCurrentlySelected: [provider.selectedServiceIndex],
        extraOnToggle: provider.handleServiceSelection,
      );
    });
  }

  Widget _buildContinueButton() {
    return Consumer<CreateServiceRequestProvider>(
        builder: (context, provider, _) {
      return CustomButton(
        width: double.infinity,
        text: 'استكمال البيانات',
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
        onPressed: provider.handleContinuePressed,
      );
    });
  }
}
