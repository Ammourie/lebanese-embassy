import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../../../core/assets_path.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widget/custom_success_dialog.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../core/widget/waiting_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../../service_locator.dart';
import '../../../category/data/remote/models/params/get_category_params.dart';
import '../../../category/data/remote/models/responses/get_category_model.dart';
import '../../../category/presentation/blocs/category_bloc.dart';
import '../../../notification/presentation/blocs/notification_bloc.dart';
import '../../../notification/presentation/screen/notification_screen.dart';
import '../../../services/presentation/screen/create_service_request.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  final _searchNameFocusNode = FocusNode();
  // final _searchKey = GlobalKey<FormFieldState<String>>();
  final _carouselController = CarouselSliderController();

  bool _loading = false;
  // bool _isRtl = false;
  GetCategorysLoaded? _categorysLoaded;
  List<Widget> _carouselItems = [];
  
  @override
  void initState() {
    super.initState();
    _initData();
    _loadCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchNameFocusNode.dispose();
    super.dispose();
  }

  void _initData() {
    _buildCarouselItems();
  }

  void _loadCategories() {
    sl<CategoryBloc>().add(GetCategorysEvent(
      getCategoryParams: GetCategoryParams(
        body: GetCategoryParamsBody()
      )
    ));
  }

  void _buildCarouselItems() {
    final bannerImages = [AssetsPath.SVG_Logo, AssetsPath.SVG_Logo];
    
    _carouselItems = bannerImages.map((image) => _buildBannerItem(image)).toList();
  }

  Widget _buildBannerItem(String imagePath) {
    return Container(
      height: 126.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        gradient: const LinearGradient(
          colors: [Color(0xff029E48), Color(0xff012D15)],
          begin: AlignmentDirectional.centerEnd,
          end: AlignmentDirectional.centerStart,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: 200.w,
              alignment: Alignment.centerRight,
              child: CustomText(
                text: 'شارك في استبانة تجربة المستخدم لتطبيق السفارة دون تسجيل الدخول',
                style: Styles.w600TextStyle().copyWith(
                  color: const Color(0xffEEFFF4),
                  fontWeight: FontWeight.w900,
                  fontSize: 14.sp
                )
              ),
            ),
          ),
          CustomPicture(
            color: Styles.colorTextWhite,
            width: 80.w,
            path: imagePath,
            fit: BoxFit.fill,
            isSVG: true,
            isLocal: true,
          )
        ],
      )
    );
  }

  Widget _buildSearchField() {
    return CustomTextField(
      height: 56.h,
      width: 326.w,
      isRtl: Provider.of<LocaleProvider>(context).isRTL,
      controller: _searchController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (Validators.isNotEmptyString(value ?? '')) {
          return null;
        }
        setState(() {});
        return "${S.of(context).validationMessage} ${S.of(context).userName}";
      },
      prefixIcon: Icon(
        Icons.search,
        color: Styles.colorPrimary,
      ),
      textStyle: Styles.w400TextStyle().copyWith(
        fontSize: 16.sp,
        color: Styles.colorText
      ),
      textAlign: Provider.of<LocaleProvider>(context).isRTL
          ? TextAlign.right
          : TextAlign.left,
      focusNode: _searchNameFocusNode,
      labelText: '',
      hintText: 'ابحث ...',
      minLines: 1,
      onChanged: (value) => setState(() {}),
      maxLines: 1,
      onFieldSubmitted: (_) {},
    );
  }

  Widget _buildNotificationBadge() {
    return BlocConsumer<NotificationBloc, NotificationState>(
      bloc: sl<NotificationBloc>(),
      listener: (context, state) {
        if (state is GetNotificationsLoaded) {
          sl<AppStateModel>().setNumOfNotificaiotn(
            state.getNotificationEntity!.notificationModelList.length
          );
        }
      },
      builder: (context, state) {
        return badges.Badge(
          badgeStyle: badges.BadgeStyle(
            badgeColor: Styles.colorPrimary,
          ),
          position: badges.BadgePosition.topEnd(top: -14),
          showBadge: (sl<AppStateModel>().numOfNotifiaction ?? 0) > 0,
          badgeContent: Text(
            (sl<AppStateModel>().numOfNotifiaction ?? 0).toString(),
            style: const TextStyle(color: Colors.white),
          ),
          child: Container(
            height: 34.w,
            width: 34.w,
            decoration: Styles.coloredRoundedDecoration(
              color: const Color(0xff097239),
              radius: 34.w,
              borderColor: const Color(0xff097239),
            ),
            child: Icon(Icons.notifications, color: Colors.white, size: 16.w),
          )
        );
      }
    );
  }

  Widget _buildCategoriesGrid() {
    return BlocConsumer<CategoryBloc, CategoryState>(
      bloc: sl<CategoryBloc>(),
      listener: (context, state) {
        if (!_loading && state is CategoryLoading) {
          _loading = true;
        } else if (state is GetCategorysLoaded) {
          _loading = false;
          _categorysLoaded = state;
        } else if (state is CategoryError) {
          _loading = false;
        }
      },
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const WaitingWidget();
        }
        
        if (state is CategoryError) {
          return ErrorWidgetScreen(
            callBack: () {
              _initData();
              _loadCategories();
            },
            message: state.message ?? "",
            height: 250.h,
            width: 250.w,
          );
        }

        if (_categorysLoaded == null) {
          return Container();
        }

        return GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(bottom: 35.w),
          mainAxisSpacing: 17.w,
          crossAxisSpacing: 17.w,
          children: _categorysLoaded!.getCategoryEntity!.categoryModelList
            .map((model) => _buildCategoryItem(model))
            .toList()
        );
      }
    );
  }

  Widget _buildCategoryItem(CategoryModel model) {
    return InkWell(
      onTap: () => _onCategoryTap(model),
      child: Container(
        width: 110.w,
        height: 110.w,
        decoration: Styles.coloredRoundedDecoration(
          color: Styles.colorBackground,
          borderColor: Styles.colorBackground,
          radius: 10.r,
          boxShadow: [
            BoxShadow(
              color: const Color(0x000000).withOpacity(0.01),
              spreadRadius: 0,
              offset: const Offset(0, 4),
              blurRadius: 16,
            )
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomPicture(
              height: 40.w,
              width: 40.w,
              fit: BoxFit.contain,
              path: model.image ?? '',
              isSVG: false,
              isLocal: false,
            ),
            CommonSizes.vSmallerSpace,
            SizedBox(
              width: 100.w,
              child: CustomText(
                text: model.name ?? '',
                style: Styles.w400TextStyle().copyWith(fontSize: 12.sp),
                alignmentGeometry: Alignment.center,
                textAlign: TextAlign.center,
              )
            )
          ],
        )
      ),
    );
  }

  void _onCategoryTap(CategoryModel model) {


    FocusManager.instance.primaryFocus?.unfocus();

    if (sl<AppStateModel>().user!.data!.adminVerify != 0) {
      showCustomMessageDialog(
        isConfirmDelete: false,
        nameToDelete: '',
        onButtonPressed: (context) => Navigator.of(context, rootNavigator: true).pop(),
        onCancelPressed: (context) => Utils.popNavigate(context),
        context: context,
      );
      return;
    }

    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      settings: const RouteSettings(name: RoutePaths.CreateServiceRequestScreen),
      screen: CreateServiceRequestScreen(
        categoryId: model.id ?? 0,
        title: model.name ?? '',
      ),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        maintainBottomViewPadding: true,
        child: Container(
          color: Styles.colorBackgroundHome,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonSizes.vBiggestSpace,
                SizedBox(
                  height: 44.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildSearchField(),
                      InkWell(
                        onTap: () {
                          Utils.pushNewScreenWithRouteSettings(
                            context,
                            settings: const RouteSettings(
                              name: RoutePaths.NotificationScreen,
                            ),
                            withNavBar: false,
                            screen: const NotificationScreen(),
                          );
                        },
                        child: _buildNotificationBadge(),
                      ),
                    ],
                  ),
                ),
                CommonSizes.vSmallSpace,
                SizedBox(
                  height: 150.h,
                  width: double.infinity,
                  child: CarouselSlider(
                    items: _carouselItems,
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      initialPage: 2,
                      enlargeFactor: 0.1,
                    ),
                  ),
                ),
                CommonSizes.vSmallSpace,
                CustomText(
                  text: 'الخدمات القنصلية',
                  style: Styles.w600TextStyle().copyWith(
                    color: Styles.colorText,
                    fontSize: 20.sp,
                    height: 24/20
                  ),
                  paddingHorizantal: 20.w,
                  alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                  textAlign: Provider.of<LocaleProvider>(context).isRTL
                    ? TextAlign.right
                    : TextAlign.left,
                ),
                CommonSizes.vSmallSpace,
                Expanded(child: _buildCategoriesGrid()),
                CommonSizes.vSmallSpace,
              ],
            )
          )
        )
      )
    );
  }
}
