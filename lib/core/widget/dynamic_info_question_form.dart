
import 'dart:convert';
import 'dart:io';

import 'package:chip_list/chip_list.dart';
import 'package:country_flags/country_flags.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../assets_path.dart';
import '../utils.dart';
import 'custom_svg_picture.dart';
 import 'package:provider/provider.dart';

import '../../features/account/data/remote/models/responses/family_group_field.dart';
import '../../features/account/data/remote/models/responses/get_field_model.dart';
import '../../features/services/data/remote/models/params/country.dart';
import '../../features/services/data/remote/models/params/create_order_service_params.dart';
import '../../l10n/locale_provider.dart';
import '../../service_locator.dart';
import '../constants.dart';
import '../routing/route_paths.dart';
import '../shared_preferences_items.dart';
import '../state/appstate.dart';
import '../styles.dart';
import '../utils/common_sizes.dart';
import 'custom_button.dart';
import 'custom_radio_tile.dart';
import 'custom_text.dart';
import 'custom_text_field.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DynamicInfoQuestionFormPage extends StatefulWidget {
  List<InfoData> infoList;
  DynamicInfoQuestionFormPage(
      {
    required this.infoList
      });

  @override
  _DynamicFormPageState createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<DynamicInfoQuestionFormPage> {



  @override
  void initState() {
    print('init');

    super.initState();
  } // Store form data for all steps



   @override
  Widget build(BuildContext context) {

    return
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.w
        ),
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.all(Radius.circular(8.r)),
            border: Border(
              right: BorderSide(
                //                   <--- left side
                color: Styles.colorPrimary,
                width: 3.0,
              ),
            )),
      child:
      Padding(
        padding: const EdgeInsets.all(0.0),
        child:
        // Column(
            // children: [
              // Expanded(
              //   child:
              // SingleChildScrollView(child:
              Column(children: [
                ...getLsitWidgte(),
             ],),
          // ),
        ),
              // SizedBox(height: 20),

            // ],
          // ),
       );
  }

  List<Widget> l = [];
  int _currentIndex=-1;
  getLsitWidgte() {
    l = [];
    int index = 0;
     widget.infoList
        .map((field) => {
      index++,
      l.addAll(_buildField(field, index)),
    })
        .toList();
    return l;
  }

  final TextEditingController textEditingController = TextEditingController();

  List<Widget> _buildField(InfoData field, int index) {
 List<Widget> wdgetLst=[];

              wdgetLst.addAll([
                CustomText(
                  text: field.name ?? '',
                  style: Styles.w400TextStyle()
                      .copyWith(fontSize: 16.sp, color: Styles.colorText),
                  alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  textAlign: Provider.of<LocaleProvider>(context).isRTL
                      ? TextAlign.right
                      : TextAlign.left,
                ),
                CommonSizes.vSmallestSpace,
              ]);

            wdgetLst.addAll([
              (field.value??'').contains('cache')?

              buildFilePreveiw(field.value??'')
              :CustomText(
                text: field.value ?? '',
                style: Styles.w400TextStyle()
                    .copyWith(fontSize: 16.sp, color: Styles.colorText),
                alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                textAlign: Provider.of<LocaleProvider>(context).isRTL
                    ? TextAlign.right
                    : TextAlign.left,
              ),
              CommonSizes.vSmallerSpace,
            ]);



          return wdgetLst;




  }
  Widget buildFilePreveiw(String path)
  {
    if(path.contains('pdf'))
      {
        return  SfPdfViewer.file(File(
path)
  // key: _pdfViewerKey,
        ) ;
      }
    else{
      return CustomPicture(path: path,isLocalFile: true,isSVG: false,fit: BoxFit.scaleDown,
        height: 150.w,
           );

    }
  }

}
