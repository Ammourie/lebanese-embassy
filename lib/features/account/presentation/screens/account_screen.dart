import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/assets_path.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import 'who_we_screen.dart';
import '../../../order/data/remote/models/params/get_order_params.dart';
import '../../../order/presentation/blocs/order_bloc.dart';
import '../../../order/presentation/screen/order_card.dart';
import '../../../services/presentation/screen/book_appointment_widget.dart';
import 'package:provider/provider.dart';

import '../../../../core/routing/route_paths.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../core/widget/waiting_widget.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../../service_locator.dart';
import '../../../category/presentation/blocs/category_bloc.dart';
import '../../../order/presentation/screen/appointment_screen.dart';
import '../../../order/presentation/screen/order_screen.dart';
import '../../../services/data/remote/models/params/create_order_service_params.dart';
import '../../data/remote/models/params/update_info_field_params.dart';
import '../blocs/account_bloc.dart';
import 'complete_profile_screen.dart';
import 'edite_profile_screen.dart';
import 'family_member_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isRtl = false;

  @override
  void dispose() {
    super.dispose();
  }
  AccountBloc _accountBloc = new AccountBloc();

  @override
  void initState() {
    super.initState();
  }

  List<Widget> widgetLsit = [];
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    isRtl = Provider.of<LocaleProvider>(context, listen: false).isRTL;

    return Scaffold(
        body: SafeArea(
            bottom: true,
            top: false,
            maintainBottomViewPadding: true,
            child: Container(
                color: Styles.colorAppBarBackground,
                width: screenSize.width,
                height: screenSize.height,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: Stack(
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 150.h,
                              decoration: Styles.coloredRoundedDecoration(
                                color: Styles.colorAppBarBackground,
                                radius: 0,
                                borderColor: Styles.colorAppBarBackground,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Row(
                                children: [
                                  // InkWell(
                                  //   onTap: (){
                                  // Navigator.pop(context);                                                },
                                  // child:
                                  SizedBox(
                                    width: 20.w,
                                    // child:
                                    // Icon(Icons.arrow_back_ios_new,color: Styles
                                    //     .colorTextWhite,)
                                  ),
                                  // ,),
                                  Expanded(
                                    child: Container(
                                      child: CustomText(
                                          textAlign: TextAlign.center,
                                          alignmentGeometry: Alignment.center,
                                          text: 'الملف الشخصي' ?? '',
                                          style: Styles.w400TextStyle()
                                              .copyWith(
                                                  fontSize: 20.sp,
                                                  color:
                                                      Styles.colorTextWhite)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                decoration: BoxDecoration(
                                    color: Styles.colorUserInfoBackGround,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50.r),
                                        topRight: Radius.circular(50.r)),
                                    border: Border(
                                      left: BorderSide(
                                        //                   <--- left side
                                        color: Styles.colorUserInfoBackGround,
                                        width: 1.0,
                                      ),
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CommonSizes.vBiggestSpace,
                                    Container(
                                      height: 37.h,
                                      child: CustomText(
                                        text: (sl<AppStateModel>()
                                                    .user!
                                                    .data!
                                                    .firstName ??
                                                'info') +
                                            '  ' +
                                            (sl<AppStateModel>()
                                                    .user!
                                                    .data!
                                                    .lastName ??
                                                'lebanon'),
                                        style: Styles.w700TextStyle().copyWith(
                                            fontSize: 20.sp,
                                            color:
                                                Styles.colorTextAccountColor),
                                        alignmentGeometry: Alignment.center,
                                      ),
                                    ),
                                    CommonSizes.vSmallestSpace,
                                    Container(
                                      height: 37.h,
                                      child: CustomText(
                                        text: (sl<AppStateModel>()
                                                .user!
                                                .data!
                                                .phone ??
                                            ''),
                                        style: Styles.w400TextStyle().copyWith(
                                            fontSize: 20.sp,
                                            color:
                                                Styles.colorTextAccountColor),
                                        alignmentGeometry: Alignment.center,
                                        paddingHorizantal: 20.w,
                                      ),
                                    ),
                                    CommonSizes.vSmallSpace,
                                   InkWell(onTap: (){

                                     Utils.pushNewScreenWithRouteSettings(context,
                                         withNavBar: false,
                                         screen: EditeProfileScreen(isEditeProfile: true,),
                                         settings: RouteSettings(name: RoutePaths.EditeProfileScreen));
                                   },child:   Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomPicture(
                                            path: AssetsPath.SVGNAVBarAccount,
                                            height: 32.w,
                                            width: 32.w,
                                            isLocal: true,
                                            isSVG: true,
                                            color: Styles.colorActiveText,
                                          ),
                                          Expanded(
                                            child: CustomText(
                                              text: 'المعلومات الشخصية',
                                              style: Styles.w700TextStyle()
                                                  .copyWith(
                                                color: Styles.colorText,
                                                fontSize: 16.sp,
                                                height: 29 / 16,
                                              ),
                                              alignmentGeometry: isRtl
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              paddingHorizantal: 20.w,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 24.w,
                                            color: Color(0xff27272A),
                                          ),
                                        ],
                                      ),
                                   )  ),
                                    CommonSizes.vSmallSpace,
                                    InkWell(child:
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomPicture(
                                            path: AssetsPath.SVG_familyMember,
                                            height: 32.w,
                                            width: 32.w,
                                            isLocal: true,
                                            isSVG: true,
                                            color: Styles.colorActiveText,
                                          ),
                                          Expanded(
                                            child: CustomText(
                                              text: 'أفراد العائلة',
                                              style: Styles.w700TextStyle()
                                                  .copyWith(
                                                color: Styles.colorText,
                                                fontSize: 16.sp,
                                                height: 29 / 16,
                                              ),
                                              alignmentGeometry: isRtl
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              paddingHorizantal: 20.w,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 24.w,
                                            color: Color(0xff27272A),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: (){
                                      Utils.pushNewScreenWithRouteSettings(context,
                                          withNavBar: false,
                                          screen: FamilyScreen(),
                                          settings: RouteSettings(name:
                                          RoutePaths.FamilyScreen)
                                      );
                                    },),
                                    CommonSizes.vSmallSpace,
                                    InkWell(
                                        onTap: () {
                                          Utils.pushNewScreenWithRouteSettings(
                                            context,
                                            settings: const RouteSettings(
                                              name: RoutePaths.OrderScreen,
                                            ),
                                            withNavBar: false,
                                            screen: const OrderScreen(),
                                          );
                                        },
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CustomPicture(
                                                path: AssetsPath.SVG_myOrder,
                                                height: 32.w,
                                                width: 32.w,
                                                isLocal: true,
                                                isSVG: true,
                                                color: Styles.colorActiveText,
                                              ),
                                              Expanded(
                                                child: CustomText(
                                                  text: 'طلباتي',
                                                  style: Styles.w700TextStyle()
                                                      .copyWith(
                                                    color: Styles.colorText,
                                                    fontSize: 16.sp,
                                                    height: 29 / 16,
                                                  ),
                                                  alignmentGeometry: isRtl
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                                  paddingHorizantal: 20.w,
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 24.w,
                                                color: Color(0xff27272A),
                                              ),
                                            ],
                                          ),
                                        )),
                                    CommonSizes.vSmallSpace,
                                   InkWell(
                                     onTap: (){


                                       Utils.pushNewScreenWithRouteSettings(context,
                                           withNavBar: false,
                                           screen: AppointmentScreen(),
                                           settings: RouteSettings(name:
                                           RoutePaths.AppointmentScreen)
                                       );
                                     },
                                   child:  Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomPicture(
                                            path:
                                                AssetsPath.SVGNAVBarAppointment,
                                            color: Styles.colorActiveText,
                                            height: 32.w,
                                            width: 32.w,
                                            isLocal: true,
                                            isSVG: true,
                                          ),
                                          Expanded(
                                            child: CustomText(
                                              text: 'مواعيدي ',
                                              style: Styles.w700TextStyle()
                                                  .copyWith(
                                                color: Styles.colorText,
                                                fontSize: 16.sp,
                                                height: 29 / 16,
                                              ),
                                              paddingHorizantal: 20.w,
                                              alignmentGeometry: isRtl
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 24.w,
                                            color: Color(0xff27272A),
                                          ),
                                        ],
                                      ),
                                   )),
                                    CommonSizes.vSmallSpace,
InkWell(child:                                      Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomPicture(
                                            path: AssetsPath.SVG_who_we,
                                            color: Styles.colorActiveText,
                                            height: 32.w,
                                            width: 32.w,
                                            isLocal: true,
                                            isSVG: true,
                                          ),
                                          Expanded(
                                            child: CustomText(
                                              text: 'من نحن؟',
                                              style: Styles.w700TextStyle()
                                                  .copyWith(
                                                color: Styles.colorText,
                                                fontSize: 16.sp,
                                                height: 29 / 16,
                                              ),
                                              paddingHorizantal: 20.w,
                                              alignmentGeometry: isRtl
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 24.w,
                                            color: Color(0xff27272A),
                                          ),
                                        ],
                                      ),
),onTap: (){
  Utils.pushNewScreenWithRouteSettings(
    context,
    settings: const RouteSettings(
      name: RoutePaths.NotificationScreen,
    ),
    withNavBar: false,
    screen:   WhoWeScreen(),
  );
},  ),
                                    CommonSizes.vSmallSpace,
                                    Container(
                                      child:

                                      InkWell(
                                          onTap: (){
                                            sl<AppStateModel>().logOut();
                                            Phoenix.rebirth(context);
                                          },
                                          child:
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomPicture(
                                            path: AssetsPath.SVG_ExistApp,
                                            color: Styles.colorActiveText,
                                            height: 32.w,
                                            width: 32.w,
                                            isLocal: true,
                                            isSVG: true,
                                          ),
                                          Expanded(
                                            child: CustomText(
                                              text: 'تسجيل الخروج',
                                              style: Styles.w700TextStyle()
                                                  .copyWith(
                                                color: Styles.colorText,
                                                fontSize: 16.sp,
                                                height: 29 / 16,
                                              ),
                                              paddingHorizantal: 20.w,
                                              alignmentGeometry: isRtl
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                            ),
                                          ),
                                        ],
                                      ) ),
                                    ),
                                    CommonSizes.vSmallSpace,
                                  ],
                                ),
                              ),
                            )
                          ]),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 100.h,
                          child:
                          BlocConsumer<AccountBloc, AccountState>(
                              bloc: _accountBloc,
                              listener: (context, AccountState state) async {
                                // GetRegisterFieldLoaded
                                if(state is GetRegisterFieldLoaded){
                                 }else
                                if(state is UpdateInfoFieldLoaded){


                                }
                              },
                              builder: (context, state) {
                                if (state is AccountLoading)
                                  return WaitingWidget(size: 250.r,);
                                if (state is AccountError)
                                  return ErrorWidgetScreen(
                                    callBack: () {
                                     },
                                    message: state.message ?? "",
                                    height: 250.h,
                                    width: 250.w,
                                  );
                                return  InkWell(child:
                                _selectedFile==null?
                                CircleAvatar(
                                backgroundColor: Styles.colorTextWhite,
                                  radius: 40.w,
                                  child:

                                  ClipOval(child:
                                  SizedBox.fromSize(
                                      size: Size.fromRadius(80.w),
                                      child:
                                      FadeInImage(
                                      color: Styles.colorTextWhite,
                                        placeholder: AssetImage(AssetsPath.PNG_NoItemImage),
                                        imageErrorBuilder: (BuildContext context,
                                            Object exception, StackTrace? stackTrace) {
                                          return Image.asset(AssetsPath.PNG_NoItemImage );
                                        },
                                        image: AssetsPath.SVG_Logo == null || AssetsPath.SVG_Logo == ""
                                            ? AssetImage(AssetsPath.PNG_NoItemImage )
                                        as ImageProvider
                                            : AssetImage(AssetsPath.SVG_Logo ) as ImageProvider,
                                        fit: BoxFit.cover,
                                      ))
                                    ,))
                                   :   CustomPicture(

                                   fit: BoxFit.fill,
                                  path:_selectedFile!.path??'',
                                  isLocal: true,

                                  isSVG: false,

                                  isCircleShape: true,
                                  width: 80.w,
                                  height: 80.w,
                                ) ,onTap: (){
                                  _showMenu();
                                },);
                              })


                      ),
                     if(_selectedListFile!=null) Positioned(
                          left: 150.w,
                          right: 150.w,

                          top: 200.h,
                          child:

                          Row(children: [
                         Expanded(child:     InkWell(child:
                            Icon(Icons.cancel_outlined,

                              color:Styles.colorTextError,
                            ),onTap: (){
                              _selectedListFile=null;
                             },)),
                          Expanded(child:    InkWell(child:
                            Icon(Icons.done,
                              color:Styles.colorPrimary,
                            ),onTap: () async{
                            String base64String;
                            if(_selectedFile!=null) {
                               final bytes = await _selectedFile!.readAsBytes();

                              // Convert the bytes to base64
                                 base64String = base64Encode(bytes);
                              _selectedListFile= FilesModelData(
                                  name:('profile')+ _selectedFile!.path.split('.').last ,
                                  field_id:'0' ,
                                  file: base64String);
                              _accountBloc.add(UpdateUpdateInfoFieldEvent(
                                   updateInfoFieldParams: UpdateInfoFieldParams(
                                       body: UpdateInfoFieldParamsBody(
                                           withFamily: true,
                                           profileImage: base64String
                                       ))));
                            }

                                               },),
                          ) ],)
                      ),
                    ],
                  ),
                ))));
  }

  void _showMenu() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,

      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('كاميرا'),
                onTap: () async {
                  Navigator.pop(context); // Close the menu
                   _selectedFile= await pickImageFromCamera();
                  setState(() {

                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('ملفاتي'),
                onTap: () async {
                  Navigator.pop(context); // Close the menu
                  _selectedFile= await _pickFile();
                  setState(() {

                  });
                },
              ),
            ],
          ),
        );
      },
    );

  }
  final ImagePicker _picker = ImagePicker();
  File? _selectedFile;
    FilesModelData?  _selectedListFile=null;
  Future<File?> pickImageFromCamera() async {
    try {
      // Pick an image from the camera
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Error picking file: $e');
      return null;
    }
  }
  Future<File?> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        // Convert FilePickerResult to File
        File file = File(result.files.single.path!);
        return file;


        print('File Path: ${file.path}');
      } else {
        // User canceled the picker
        print('File picker canceled');
      }

    } catch (e) {
      print('Error picking file: $e');
    }
    return null;

  }

}
