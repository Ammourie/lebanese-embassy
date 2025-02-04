import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chip_list/chip_list.dart';
import 'package:country_flags/country_flags.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lebaneseEmbassy/core/widget/select_field_processor.dart';
import '../assets_path.dart';
import '../utils.dart';
import 'custom_svg_picture.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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

class DynamicQuestionFormPage extends StatefulWidget {
  final List<GroupedField> listdata;
  final GlobalKey<FormState> formKey;
  final Function(FilesModelDataList) onValueSelected;
  final VoidCallback callback;

  DynamicQuestionFormPage({
    required this.listdata,
    required this.formKey,
    required this.onValueSelected,
    required this.callback,
  });

  @override
  _DynamicFormPageState createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<DynamicQuestionFormPage> {
  final Map<String, dynamic> _formData = {}; // Store form data here
  List<GroupedField> listdataShown = [];

  @override
  void initState() {
    print('init');
    _initializeFormFields();

    super.initState();
  } // Store form data for all steps

  void _initializeFormFields() {
    listdataShown = [];
    try {
      for (var field in widget.listdata) {
        _formData[field.name ?? ''] = ''; // Initialize with empty values
        if (field.group_sort!.contains('0-')) {
          listdataShown.add(field);
        }
        if (field.group_sort!.contains('-') == false) {
          listdataShown.add(field);
        }
      }
      print('eee');
    } catch (e) {
      print(e);
    }
  }

  _filterFields(String answer) {
    listdataShown = [];
    if (answer.compareTo("نعم") != 0) {
      for (var field in widget.listdata) {
        if (field.group_sort!.contains('0-')) {
          listdataShown.add(field);
        }
        if (field.group_sort!.contains('-') == false) {
          listdataShown.add(field);
        }
      }
    } else {
      for (var field in widget.listdata) {
        if (field.group_sort!.contains('1-')) {
          listdataShown.add(field);
        }
        if (field.group_sort!.contains('-') == false) {
          listdataShown.add(field);
        }
      }
    }
    print('ddddddddddddd' + listdataShown.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (sl<AppStateModel>().shouldUpdateWidget != null &&
        sl<AppStateModel>().shouldUpdateWidget == true) {
      sl<AppStateModel>().setshouldUpdateWidget(false);
      _initializeFormFields();
    }

    return
        // SingleChildScrollView(
        // child:
        Padding(
      padding: const EdgeInsets.all(0.0),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...getLsitWidgte(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              width: double.infinity,

              text: 'التالي',

              style: Styles.w700TextStyle().copyWith(
                fontSize: 16.sp,
                height: 24 / 16,
                color: Styles.colorTextWhite,
              ),
              raduis: 8.r,
              textAlign: TextAlign.center,
              color: Styles.colorPrimary,
              fillColor: Styles.colorPrimary,
              // width: 350.w,
              height: 54.h,
              alignmentDirectional: AlignmentDirectional.center,
              onPressed: _submitForm,
            ),
            CommonSizes.vBigSpace,
          ],
        ),
      ),
    );
  }

  List<Widget> l = [];
  int _currentIndex = -1;
  getLsitWidgte() {
    l = [];
    int index = 0;
    listdataShown
        .map((field) => {
              index++,
              l.addAll(_buildField(field, index)),
            })
        .toList();
    return l;
  }

  final TextEditingController textEditingController = TextEditingController();

  List<Widget> _buildField(GroupedField field, int index) {
    if (field.country!.compareTo('الكل') == 0 ||
        field.country!
                .compareTo(Provider.of<LocaleProvider>(context).country) ==
            0) {
      switch (field.type) {
        case 'text':
        case 'email':
          List<Widget> wdgetLst = [];
          if (field.group!.contains('بيانات التواصل و السكن')) {
            List<String> lst = field.group!.split('-');
            if (lst.length == 1 && field.description != null) {
              lst = field.description!.split('-');
            }

            if (field.field_sort!.compareTo('1') == 0)
              wdgetLst.addAll([
                CustomText(
                  text: lst.last ?? '',
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
              CustomTextField(
                // height: 60.h,

                // width: 217.w,
                initialValue: field.values ?? "",

                isRtl: Provider.of<LocaleProvider>(context).isRTL,
                // textKey: _usernameKey,
                // controller: _usernameController,

                textInputAction: TextInputAction.next,

                keyboardType: TextInputType.text,
                validator: (value) {
                  int indexed =
                      listdataShown.indexWhere((e) => e.id == field.id);

                  listdataShown[indexed].values = value;
                  if ((value == null || value.isEmpty) && field.required == 1) {
                    return '${field.name} is required';
                  }
                  return null;
                },

                // onSaved: (value) => _formData[field.name ?? ''] = value,
                // if (Validators.isValidEmail(value ?? '')) {
                //   return null;
                // }
                // return "${S.of(context).validationMessage} ${S.of(context).userName}";
                // },

                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: Styles.colorPrimary,
                ),
                textStyle: Styles.w400TextStyle().copyWith(
                    fontSize: 16.sp, color: Styles.colorTextTextField),
                textAlign: Provider.of<LocaleProvider>(context).isRTL
                    ? TextAlign.right
                    : TextAlign.left,
                // focusNode: _usernameFocusNode,
                hintText: field.name ?? '',
                minLines: 1,
                onChanged: (String value) {
                  widget.formKey.currentState?.validate();
                  int indexed =
                      listdataShown.indexWhere((e) => e.id == field.id);

                  field.values = value;
                  listdataShown[indexed].values = value;

                  _formData[field.name ?? ''] = value;
                  //   if (_usernameKey.currentState!.validate()) {}
                  //   setState(() {});
                },
                maxLines: 1,
                onFieldSubmitted: (String value) {
                  field.values = value;
                  int indexed =
                      listdataShown.indexWhere((e) => e.id == field.id);

                  listdataShown[indexed].values = value;

                  _formData[field.name ?? ''] = value;
                },
              ),
              CommonSizes.vSmallerSpace,
            ]);
          } else {
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
              CustomTextField(
                // height: 60.h,

                // width: 217.w,
                initialValue: field.values ?? "",

                isRtl: Provider.of<LocaleProvider>(context).isRTL,
                // textKey: _usernameKey,
                // controller: _usernameController,

                textInputAction: TextInputAction.next,

                keyboardType: TextInputType.text,
                validator: (value) {
                  // [index].values = ;
                  int indexed =
                      listdataShown.indexWhere((e) => e.id == field.id);
                  listdataShown[indexed].values = value;
                  if ((value == null || value.isEmpty) && field.required == 1) {
                    return '${field.name} is required';
                  }
                  return null;
                },

                // onSaved: (value) => _formData[field.name ?? ''] = value,
                // if (Validators.isValidEmail(value ?? '')) {
                //   return null;
                // }
                // return "${S.of(context).validationMessage} ${S.of(context).userName}";
                // },

                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: Styles.colorPrimary,
                ),
                textStyle: Styles.w400TextStyle().copyWith(
                    fontSize: 16.sp, color: Styles.colorTextTextField),
                textAlign: Provider.of<LocaleProvider>(context).isRTL
                    ? TextAlign.right
                    : TextAlign.left,
                // focusNode: _usernameFocusNode,
                hintText: field.name ?? '',
                minLines: 1,
                onChanged: (String value) {
                  widget.formKey.currentState?.validate();
                  int indexed =
                      listdataShown.indexWhere((e) => e.id == field.id);
                  listdataShown[indexed].values = value;

                  _formData[field.name ?? ''] = value;
                  //   if (_usernameKey.currentState!.validate()) {}
                  //   setState(() {});
                },
                maxLines: 1,
                onFieldSubmitted: (String value) {
                  field.values = value;
                  int indexed =
                      listdataShown.indexWhere((e) => e.id == field.id);
                  listdataShown[indexed].values = value;
                  _formData[field.name ?? ''] = value;
                },
              ),
              CommonSizes.vSmallerSpace,
            ]);
          }
          return wdgetLst;
        case 'date':
          if (field.values!.isNotEmpty) {
            textEditingController.text = field.values ?? '';
          }
          return [
            InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1901, 1),
                    lastDate: DateTime(2100),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary:
                                Styles.colorPrimary, // Header background color
                            onPrimary: Colors.white, // Header text color
                            onSurface: Colors.black, // Body text color
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Styles.colorPrimary, // Button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  //  showDatePicker(
                  // context: context,
                  // initialDate: DateTime(DateTime.now().year,
                  // DateTime.now().month,DateTime.now().day),
                  //
                  //
                  // firstDate: DateTime(1901, 1),
                  // lastDate: DateTime(2100));

                  if (picked != null && picked != field.values)
                    setState(() {
                      field.values = picked.toString();
                      textEditingController.value =
                          TextEditingValue(text: picked.toString());
                    });
                  if (picked != null) {
                    // Update the controller text to show the selected date
                    // _controller.text =
                    // "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                  }
                },
                child: CustomText(
                  text: field.name ?? '',
                  style: Styles.w400TextStyle()
                      .copyWith(fontSize: 16.sp, color: Styles.colorText),
                  alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  textAlign: Provider.of<LocaleProvider>(context).isRTL
                      ? TextAlign.right
                      : TextAlign.left,
                )),
            CommonSizes.vSmallestSpace,
            InkWell(
                onTap: () async {
                  // onSubmit: (Object? value) {
                  // Navigator.pop(context);
                  // setState(() {
                  // dynamicFormsList[index].value = DateFormat("dd/MM/y")
                  //     .format(dateRangePickerController.selectedDate!);
                  // textEditingController.text = dynamicFormsList[index].value;
                  // });
                  // },
                  // onCancel: () {
                  // Navigator.pop(context);
                  // },
                  // );
                  // });

                  // DateTime? pickedDate = await showCupertinoModalPopup(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return CupertinoActionSheet(
                  //       title: Text("Select Date"),
                  //       actions: [
                  //         CupertinoDatePicker(
                  //           initialDateTime: DateTime(DateTime.now().year - 18,
                  //               DateTime.now().month,DateTime.now().day),
                  //           minimumYear: 1900,
                  //           maximumYear: 2101,
                  //           onDateTimeChanged: (DateTime newDate) {
                  //             setState(() {
                  //               // selectedDate = newDate;
                  //             });
                  //           },
                  //         ),
                  //       ],
                  //       cancelButton: CupertinoActionSheetAction(
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //         },
                  //         child: Text("Cancel"),
                  //       ),
                  //     );
                  //   },
                  // );
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1901, 1),
                    lastDate: DateTime(2100),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary:
                                Styles.colorPrimary, // Header background color
                            onPrimary: Colors.white, // Header text color
                            onSurface: Colors.black, // Body text color
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Styles.colorPrimary, // Button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null && picked != field.values)
                    setState(() {
                      field.values = Utils.getDateFormated(picked);
                      // picked.toString();
                      textEditingController.value =
                          TextEditingValue(text: Utils.getDateFormated(picked));
                    });
                  if (picked != null) {
                    // Update the controller text to show the selected date
                    // _controller.text =
                    // "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                  }
                },
                child: CustomTextField(
                  // height: 60.h,

                  // width: 217.w,
                  //  : true,
                  readonly: true,

                  controller: textEditingController,
                  isRtl: Provider.of<LocaleProvider>(context).isRTL,
                  // textKey: _usernameKey,
                  // controller: _usernameController,
                  textInputAction: TextInputAction.next,

                  keyboardType: TextInputType.text,
                  validator: (value) {
                    // [index].values = ;
                    int indexed =
                        listdataShown.indexWhere((e) => e.id == field.id);
                    listdataShown[indexed].values = value;
                    if ((value == null || value.isEmpty) &&
                        field.required == 1) {
                      return '${field.name} is required';
                    }
                    return null;
                  },

                  // onSaved: (value) => _formData[field.name ?? ''] = value,
                  // if (Validators.isValidEmail(value ?? '')) {
                  //   return null;
                  // }
                  // return "${S.of(context).validationMessage} ${S.of(context).userName}";
                  // },

                  prefixIcon: Icon(
                    Icons.person_2_outlined,
                    color: Styles.colorPrimary,
                  ),
                  textStyle: Styles.w400TextStyle().copyWith(
                      fontSize: 16.sp, color: Styles.colorTextTextField),
                  textAlign: Provider.of<LocaleProvider>(context).isRTL
                      ? TextAlign.right
                      : TextAlign.left,
                  // focusNode: _usernameFocusNode,
                  hintText: field.name ?? '',
                  minLines: 1,
                  onChanged: (String value) {
                    widget.formKey.currentState?.validate();
                    int indexed =
                        listdataShown.indexWhere((e) => e.id == field.id);
                    listdataShown[indexed].values = value;

                    _formData[field.name ?? ''] = value;
                    //   if (_usernameKey.currentState!.validate()) {}
                    //   setState(() {});
                  },
                  maxLines: 1,
                  onFieldSubmitted: (String value) {
                    field.values = value;
                    int indexed =
                        listdataShown.indexWhere((e) => e.id == field.id);
                    listdataShown[indexed].values = value;
                    _formData[field.name ?? ''] = value;
                  },
                )),
            CommonSizes.vSmallerSpace,
          ];

        case 'number':
          return [
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
            CustomTextField(
              height: 56.h,
              // width: 217.w,
              initialValue: field.values,
              isRtl: Provider.of<LocaleProvider>(context).isRTL,
              // textKey: _usernameKey,
              // controller: _usernameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (value) {
                if ((value == null || value.isEmpty) && field.required == 1) {
                  return '${field.name} is required';
                }
                return null;
              },
              // onSaved: (value) => _formData[field.name ?? ''] = value,
              // if (Validators.isValidEmail(value ?? '')) {
              //   return null;
              // }
              // return "${S.of(context).validationMessage} ${S.of(context).userName}";
              // },

              prefixIcon: Icon(
                Icons.person_2_outlined,
                color: Styles.colorPrimary,
              ),
              textStyle: Styles.w400TextStyle()
                  .copyWith(fontSize: 16.sp, color: Styles.colorTextTextField),
              textAlign: Provider.of<LocaleProvider>(context).isRTL
                  ? TextAlign.right
                  : TextAlign.left,
              // focusNode: _usernameFocusNode,
              hintText: field.name ?? '',
              minLines: 1,
              onChanged: (String value) {
                int indexed = listdataShown.indexWhere((e) => e.id == field.id);

                listdataShown[indexed].values = value;
                widget.formKey.currentState?.validate();

                //   if (_usernameKey.currentState!.validate()) {}
                //   setState(() {});
              },
              maxLines: 1,
              onFieldSubmitted: (String value) {},
            ),
            CommonSizes.vSmallerSpace,
          ];
        case 'select':
          return [
            SelectFieldProcessor().buildSelectField(
              context,
              field,
              _formData,
              listdataShown,
              setState,
            )
          ];
        // case 'select':
        //   int selectedIndex = 0;
        //   field.optionsList = [];

        //   bool familyEmpty = false;
        //   if (field.options!.contains('family')) {
        //     String family = sl<AppStateModel>()
        //             .prefs
        //             .getString(SharedPreferencesKeys.USER_Family_Data) ??
        //         '';
        //     FamilyGroupField? familyGroupField;

        //     if (family.isEmpty || family.compareTo('null') == 0) {
        //       // "name": "صلة القرابة",
        //       familyEmpty = true;
        //       familyGroupField = null;
        //     } else {
        //       familyGroupField = FamilyGroupField.fromJson(jsonDecode(family));
        //       familyEmpty = false;
        //     }
        //     if (familyEmpty) {
        //     } else {
        //       for (int i = 0; i < familyGroupField!.groupedFields.length; i++) {
        //         GroupedField groupedField = familyGroupField
        //             .groupedFields[familyGroupField.groups[i] ?? '']!
        //             .where((e) => e.name == 'الاسم الشخصي')
        //             .first;
        //         field.optionsList!.add(groupedField.values ?? '');
        //       }
        //     }

        //     return [
        //       CustomText(
        //         text: field.name ?? '',
        //         style: Styles.w400TextStyle()
        //             .copyWith(fontSize: 16.sp, color: Styles.colorText),
        //         alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
        //             ? Alignment.centerRight
        //             : Alignment.centerLeft,
        //         textAlign: Provider.of<LocaleProvider>(context).isRTL
        //             ? TextAlign.right
        //             : TextAlign.left,
        //       ),
        //       CommonSizes.vSmallestSpace,
        //       Container(
        //         child: ChipList(
        //           listOfChipNames: (field.optionsList ?? [])
        //               .map((option) => option ?? '')
        //               .toList(),
        //           activeTextColorList: [Styles.colorTextWhite],
        //           activeBgColorList: [Styles.colorPrimary],
        //           checkmarkColor: Styles.colorTextWhite,
        //           showCheckmark: false,
        //           inactiveBgColorList: [Styles.colorbtnGray.withOpacity(0.5)],
        //           shouldWrap: true,
        //           style: Styles.w700TextStyle()
        //               .copyWith(color: Styles.colorTextWhite, fontSize: 16.sp),
        //           runSpacing: 8.w,
        //           spacing: 8.w,
        //           inactiveTextColorList: [Styles.colorIconInActive],
        //           listOfChipIndicesCurrentlySelected:
        //               _formData[field.name ?? ''] != null
        //                   ? [
        //                       (field.optionsList ?? [])
        //                           .indexOf(_formData[field.name ?? ''])
        //                     ]
        //                   : [],
        //           extraOnToggle: (currentIndex) {
        //             setState(() {
        //               int indexed =
        //                   listdataShown.indexWhere((e) => e.id == field.id);
        //               String valueSeleected =
        //                   (field.optionsList ?? [])[currentIndex];
        //               listdataShown[indexed].values = valueSeleected;
        //               _formData[field.name ?? ''] = valueSeleected;
        //             });
        //           },
        //         ),
        //       ),
        //       CommonSizes.vSmallerSpace,
        //     ];
        //   } else if (field.options!.contains('بلدان')) {
        //     List<CountryModel> countryOption = [];

        //     var json = jsonDecode(countryJsonData);
        //     if (json != null) {
        //       json.forEach((v) {
        //         countryOption!.add(new CountryModel.fromJson(v));
        //       });
        //     }

        //     if (_formData[field.name ?? ''] == '') {
        //       CountryModel value = countryOption!.first;
        //       int indexed = listdataShown.indexWhere((e) => e.id == field.id);
        //       listdataShown[indexed].values = value!.name;
        //       _formData[field.name ?? ''] = value.name;
        //     } else {
        //       int indexed = listdataShown.indexWhere((e) => e.id == field.id);
        //       CountryModel? value = countryOption!
        //           .where((e) => e.name == _formData[field.name ?? ''])
        //           .first;
        //       value = value == null ? countryOption.first : value;
        //       listdataShown[indexed].values = value!.name;

        //       selectedIndex = 0;
        //       selectedIndex =
        //           countryOption.indexWhere((e) => e!.name == value!.name);
        //     }

        //     return [
        //       CustomText(
        //         text: field.name ?? '',
        //         style: Styles.w400TextStyle()
        //             .copyWith(fontSize: 16.sp, color: Styles.colorText),
        //         alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
        //             ? Alignment.centerRight
        //             : Alignment.centerLeft,
        //         textAlign: Provider.of<LocaleProvider>(context).isRTL
        //             ? TextAlign.right
        //             : TextAlign.left,
        //       ),
        //       CommonSizes.vSmallestSpace,
        //       Container(
        //           child: DropdownButtonFormField<CountryModel>(
        //         value: selectedIndex == -1
        //             ? countryOption!.first
        //             : countryOption![selectedIndex],
        //         decoration: InputDecoration(
        //             labelText: '',
        //             contentPadding:
        //                 EdgeInsets.symmetric(vertical: 0, horizontal: 20.w),
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.all(Radius.circular(8.r)),
        //             )),
        //         items: (countryOption ?? [])
        //             .map((option) => DropdownMenuItem(
        //                 value: option,
        //                 child: Row(
        //                   children: [
        //                     Container(
        //                       width: 20.w,
        //                       height: 20.w,
        //                       child: FittedBox(
        //                           fit: BoxFit.fill,
        //                           child: CountryFlag.fromCountryCode(
        //                             option.code,
        //                             width: 20.w,
        //                             height: 20.w,
        //                           )),
        //                     ),
        //                     CommonSizes.hSmallestSpace,
        //                     Text(option.name)
        //                   ],
        //                 )))
        //             .toList(),
        //         onChanged: (value) {
        //           setState(() {
        //             int indexed =
        //                 listdataShown.indexWhere((e) => e.id == field.id);
        //             listdataShown[indexed].values = value!.name;
        //             _formData[field.name ?? ''] = value.name;
        //           });
        //         },
        //         validator: (value) {
        //           if ((value == null) && field.required == 1) {
        //             return 'Please select ${field.name}';
        //           }
        //           return null;
        //         },
        //       )),
        //       CommonSizes.vSmallerSpace,
        //     ];
        //   } else {
        //     field.optionsList = field.options != null
        //         ? field.options.toString().split('،')
        //         : [];
        //     field.optionsList!.removeWhere((str) => str.isEmpty);
        //     setState(() {

        //     });

        //     if (field.optionsList == null || field.optionsList!.length == 0) {
        //       index = -1;
        //       return [
        //         CustomText(
        //           text: field.name ?? '',
        //           style: Styles.w400TextStyle()
        //               .copyWith(fontSize: 16.sp, color: Styles.colorText),
        //           alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
        //               ? Alignment.centerRight
        //               : Alignment.centerLeft,
        //           textAlign: Provider.of<LocaleProvider>(context).isRTL
        //               ? TextAlign.right
        //               : TextAlign.left,
        //         ),
        //         CommonSizes.vSmallestSpace,
        //         Container(
        //           child: ChipList(
        //             listOfChipNames: (field.optionsList ?? [])
        //                 .map((option) => option ?? '')
        //                 .toList(),
        //             activeTextColorList: [Styles.colorTextWhite],
        //             activeBgColorList: [Styles.colorPrimary],
        //             checkmarkColor: Styles.colorTextWhite,
        //             inactiveBgColorList: [Styles.colorbtnGray.withOpacity(0.5)],
        //             shouldWrap: true,
        //             showCheckmark: false,
        //             style: Styles.w700TextStyle().copyWith(
        //                 color: Styles.colorTextWhite, fontSize: 16.sp),
        //             runSpacing: 8.w,
        //             spacing: 8.w,
        //             inactiveTextColorList: [Styles.colorIconInActive],
        //             listOfChipIndicesCurrentlySelected:
        //                 _formData[field.name ?? ''] != null
        //                     ? [
        //                         (field.optionsList ?? [])
        //                             .indexOf(_formData[field.name ?? ''])
        //                       ]
        //                     : [],
        //             extraOnToggle: (currentIndex) {
        //               setState(() {
        //                 int indexed =
        //                     listdataShown.indexWhere((e) => e.id == field.id);
        //                 String valueSeleected =
        //                     (field.optionsList ?? [])[currentIndex];
        //                 listdataShown[indexed].values = valueSeleected;
        //                 _formData[field.name ?? ''] = valueSeleected;
        //               });
        //             },
        //           ),
        //         ),
        //         CommonSizes.vSmallerSpace,
        //       ];
        //     } else {
        //       if (field.optionsList!.first.contains(')')) {
        //         List<String> textInsideThelist = [];
        //         List<String> textInsideUnderThelist = [];

        //         for (String segment in field.optionsList ?? []) {
        //           RegExp insideParentheses = RegExp(r"\((.*?)\)");
        //           Match? insideMatch = insideParentheses.firstMatch(segment);
        //           if (insideMatch != null)
        //             textInsideUnderThelist.add(insideMatch.group(1) ?? '');

        //           RegExp outsideParentheses = RegExp(r"(.*?)(?=\()");
        //           Match? outsideMatch = outsideParentheses.firstMatch(segment);
        //           if (outsideMatch != null)
        //             textInsideThelist.add(outsideMatch.group(1)!.trim() ?? '');
        //         }
        //         int index = -1;
        //         for (int i = 0; i < textInsideThelist.length; i++) {
        //           if ((_formData[field.name ?? ''])
        //               .toString()
        //               .contains(textInsideThelist[i])) {
        //             index = i;
        //           }
        //         }
        //         return [
        //           CustomText(
        //             text: field.name ?? '',
        //             style: Styles.w400TextStyle()
        //                 .copyWith(fontSize: 16.sp, color: Styles.colorText),
        //             alignmentGeometry:
        //                 Provider.of<LocaleProvider>(context).isRTL
        //                     ? Alignment.centerRight
        //                     : Alignment.centerLeft,
        //             textAlign: Provider.of<LocaleProvider>(context).isRTL
        //                 ? TextAlign.right
        //                 : TextAlign.left,
        //           ),
        //           CommonSizes.vSmallestSpace,
        //           Container(
        //             child: ChipList(
        //               listOfChipNames: (textInsideThelist ?? [])
        //                   .map((option) => option ?? '')
        //                   .toList(),
        //               activeTextColorList: [Styles.colorTextWhite],
        //               activeBgColorList: [Styles.colorPrimary],
        //               checkmarkColor: Styles.colorTextWhite,
        //               inactiveBgColorList: [
        //                 Styles.colorbtnGray.withOpacity(0.5)
        //               ],
        //               shouldWrap: true,
        //               showCheckmark: false,
        //               style: Styles.w700TextStyle().copyWith(
        //                   color: Styles.colorTextWhite, fontSize: 16.sp),
        //               runSpacing: 8.w,
        //               spacing: 8.w,
        //               inactiveTextColorList: [Styles.colorIconInActive],
        //               listOfChipIndicesCurrentlySelected:
        //                   _formData[field.name ?? ''] != null
        //                       ? [
        //                           textInsideThelist
        //                               .indexOf(_formData[field.name ?? ''])
        //                         ]
        //                       : [],
        //               extraOnToggle: (currentIndex) {
        //                 setState(() {
        //                   int indexed =
        //                       listdataShown.indexWhere((e) => e.id == field.id);
        //                   String valueSeleected =
        //                       textInsideThelist[currentIndex];
        //                   listdataShown[indexed].values = valueSeleected;
        //                   _formData[field.name ?? ''] = valueSeleected;
        //                 });
        //               },
        //             ),
        //           ),
        //           CommonSizes.vSmallestSpace,
        //           CustomText(
        //             text: index == -1
        //                 ? textInsideUnderThelist!.first
        //                 : textInsideUnderThelist[index],
        //             style: Styles.w400TextStyle().copyWith(
        //                 fontSize: 16.sp, color: Styles.colorTextError),
        //             alignmentGeometry:
        //                 Provider.of<LocaleProvider>(context).isRTL
        //                     ? Alignment.centerRight
        //                     : Alignment.centerLeft,
        //             textAlign: Provider.of<LocaleProvider>(context).isRTL
        //                 ? TextAlign.right
        //                 : TextAlign.left,
        //           ),
        //           CommonSizes.vSmallerSpace,
        //         ];
        //       } else {
        //         int index = -1;
        //         index = field.optionsList!.indexOf(_formData[field.name ?? '']);
        //         return [
        //           CustomText(
        //             text: field.name ?? '',
        //             style: Styles.w400TextStyle()
        //                 .copyWith(fontSize: 16.sp, color: Styles.colorText),
        //             alignmentGeometry:
        //                 Provider.of<LocaleProvider>(context).isRTL
        //                     ? Alignment.centerRight
        //                     : Alignment.centerLeft,
        //             textAlign: Provider.of<LocaleProvider>(context).isRTL
        //                 ? TextAlign.right
        //                 : TextAlign.left,
        //           ),
        //           CommonSizes.vSmallestSpace,
        //           Container(
        //             child: ChipList(
        //               listOfChipNames: (field.optionsList ?? [])
        //                   .map((option) => option ?? '')
        //                   .toList(),
        //               showCheckmark: false,
        //               activeTextColorList: [Styles.colorTextWhite],
        //               activeBgColorList: [Styles.colorPrimary],
        //               checkmarkColor: Styles.colorTextWhite,
        //               inactiveBgColorList: [
        //                 Styles.colorbtnGray.withOpacity(0.5)

        //               ],
        //               shouldWrap: true,
        //               style: Styles.w700TextStyle().copyWith(
        //                   color: Styles.colorTextWhite, fontSize: 16.sp),
        //               runSpacing: 8.w,
        //               spacing: 8.w,
        //               inactiveTextColorList: [Styles.colorIconInActive],
        //               listOfChipIndicesCurrentlySelected:
        //                   _formData[field.name ?? ''] != null
        //                       ? [
        //                           (field.optionsList ?? [])
        //                               .indexOf(_formData[field.name ?? ''])
        //                         ]
        //                       : [],
        //               extraOnToggle: (currentIndex) {
        //                 setState(() {
        //                   int indexed =
        //                       listdataShown.indexWhere((e) => e.id == field.id);
        //                   String valueSeleected =
        //                       (field.optionsList ?? [])[currentIndex];
        //                   listdataShown[indexed].values = valueSeleected;
        //                   _formData[field.name ?? ''] = valueSeleected;
        //                 });
        //               },
        //             ),
        //           ),
        //           CommonSizes.vSmallerSpace,
        //         ];
        //       }
        //     }
        //   }

        case 'checkbox':
          if (_formData[field.name ?? ''] == null ||
              _formData[field.name ?? ''] == '') {
            _formData[field.name ?? ''] = field.optionsList![1];
            int indexed = listdataShown.indexWhere((e) => e.id == field.id);

            listdataShown[indexed].values = field.optionsList![1];
          }
          field.optionsList!.removeWhere((e) => e.isEmpty);
          List<Widget> lst = [];
          for (int i = 0; i < field.optionsList!.length!; i++) {
            lst.add(
              Expanded(
                  child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity:
                    ListTileControlAffinity.leading, // Checkbox on the right
                activeColor: Styles.colorPrimary,
                title: CustomText(
                  text: field.optionsList![i] ?? '',
                  style: Styles.w400TextStyle()
                      .copyWith(fontSize: 16.sp, color: Styles.colorText),
                  alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  textAlign: Provider.of<LocaleProvider>(context).isRTL
                      ? TextAlign.right
                      : TextAlign.left,
                ),
                value: _formData[field.name ?? '']
                        .toString()
                        .compareTo(field.optionsList![i]) ==
                    0,
                onChanged: (value) {
                  int indexed =
                      listdataShown.indexWhere((e) => e.id == field.id);

                  listdataShown[indexed].values = field.optionsList![i];
                  field.values = field.optionsList![i];
                  _formData[field.name ?? ''] = field.optionsList![i] ?? '';
                  _filterFields(field.optionsList![i] ?? '');
                  ;
                  setState(() {});
                },
              )),
            );
            lst.add(
              CommonSizes.hSmallerSpace,
            );
          }

          return [
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
            Row(
              children: lst,
            ),
            CommonSizes.vSmallerSpace,
          ];
        case 'radio':
          if (_formData[field.name ?? ''] == null)
            _formData[field.name ?? ''] = field.optionsList![0];
          List<Widget> lst = [];

          for (int i = 0; i < field.optionsList!.length!; i++) {
            lst.add(
              CustomRadioTile(
                groupVal: i,
                val: field.optionsList!.indexWhere(
                    (e) => e.compareTo(_formData[field.name ?? ''] ?? '') == 0),
                onChange: (value) {
                  int indexed =
                      listdataShown.indexWhere((e) => e.id == field.id);

                  listdataShown[indexed].values = field.optionsList![i];
                  _formData[field.name ?? ''] = field.optionsList![i] ?? '';
                  setState(() {});
                },
                top: 0,
                bottom: 0,
                child: CustomText(
                  paddingHorizantal: 10.w,
                  text: field.optionsList![i] ?? '',
                  style: Styles.w400TextStyle()
                      .copyWith(fontSize: 16.sp, color: Styles.colorText),
                  alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  textAlign: Provider.of<LocaleProvider>(context).isRTL
                      ? TextAlign.right
                      : TextAlign.left,
                ),
              ),
            );
            lst.add(
              CommonSizes.hSmallerSpace,
            );
          }
          return [
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
            Row(
              children: lst,
            ),
            CommonSizes.vSmallerSpace,
          ];

        // CheckboxListTile(
        // title: Text(field.name ?? ''),
        // value:   false,
        //
        // onChanged: (value) {
        //   setState(() {
        //     _formData[field.name ?? ''] = value;
        //   });
        // },
        // );
        case 'file':
          return [
            CustomText(
              text: (field.name ?? ''),
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

            // field.id%2==0?
            InkWell(
                onTap: () async {
                  // _selectedFile=;
                  _showMenuWithPreview(field);
                  // await    pickImageFromCamera();
                },
                child: CustomTextField(
                  height: 56.h,
                  // width: 217.w,
                  readonly: true,

                  isRtl: Provider.of<LocaleProvider>(context).isRTL,
                  // textKey: _usernameKey,
                  // controller: _usernameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if ((field.values!.isEmpty) && field.required == 1) {
                      return '${field.name} is required';
                    }
                    return null;
                  },
                  // onSaved: (value) => _formData[field.name ?? ''] = value,
                  // if (Validators.isValidEmail(value ?? '')) {
                  //   return null;
                  // }
                  // return "${S.of(context).validationMessage} ${S.of(context).userName}";
                  // },

                  suffixIcon: field.values!.isEmpty
                      ? Icon(
                          Icons.file_upload_outlined,
                          color: Styles.colorPrimary,
                        )
                      : Icon(
                          Icons.check,
                          color: Styles.colorPrimary,
                        ),
                  textStyle: Styles.w400TextStyle().copyWith(
                      fontSize: 16.sp, color: Styles.colorTextTextField),
                  textAlign: Provider.of<LocaleProvider>(context).isRTL
                      ? TextAlign.right
                      : TextAlign.left,
                  // focusNode: _usernameFocusNode,
                  hintText: field.values!.isEmpty
                      ? ("أضف ملف" ?? '')
                      : (field.name ?? '') + field!.values!.split('.').last,

                  // field.name ?? '',
                  minLines: 1,
                  onChanged: (String value) {
                    int indexed =
                        listdataShown.indexWhere((e) => e.id == field.id);

                    listdataShown[indexed].values = value;
                    widget.formKey.currentState?.validate();

                    //   if (_usernameKey.currentState!.validate()) {}
                    //   setState(() {});
                  },
                  maxLines: 1,
                  onFieldSubmitted: (String value) {},
                )),
//                :
//            InkWell(onTap: () async {
//
//
//
//                // _selectedFile=;
//               _showMenu( field);
//               // await    pickImageFromCamera();
//
//             },child:
//
//       field.values!.isEmpty?
//             CustomTextField(
//               height: 56.h,
//               // width: 217.w,
//               readonly: true,
//
//               isRtl: Provider.of<LocaleProvider>(context).isRTL,
//               // textKey: _usernameKey,
//               // controller: _usernameController,
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.number,
//               validator: (value) {
//
//                 // if ((value == null || value.isEmpty) && field.required == 1) {
//                 //   return '${field.name} is required';
//                 // }
//                 return null;
//               },
//               // onSaved: (value) => _formData[field.name ?? ''] = value,
//               // if (Validators.isValidEmail(value ?? '')) {
//               //   return null;
//               // }
//               // return "${S.of(context).validationMessage} ${S.of(context).userName}";
//               // },
//
//               suffixIcon:
//       field.values!.isEmpty?
//
//               Icon(
//                 Icons.file_upload_outlined,
//                 color: Styles.colorPrimary,
//               ):
//
//       Icon(
//         Icons.preview,
//         color: Styles.colorPrimary,
//        ),
//               textStyle: Styles.w400TextStyle()
//                   .copyWith(fontSize: 16.sp, color: Styles.colorTextTextField),
//               textAlign: Provider.of<LocaleProvider>(context).isRTL
//                   ? TextAlign.right
//                   : TextAlign.left,
//               // focusNode: _usernameFocusNode,
//               hintText:
//               field.values!.isEmpty?
//               ("أضف ملف"??'') :
//               (field.name??'')+ field!.values!.split('.').last,
//
//
//               // field.name ?? '',
//               minLines: 1,
//               onChanged: (String value) {
//                 int indexed=listdataShown.indexWhere((e)=>e.id==field.id);
//
//                 listdataShown[indexed].values = value;
//                 widget.formKey.currentState?.validate();
//
//                 //   if (_usernameKey.currentState!.validate()) {}
//                 //   setState(() {});
//               },
//               maxLines: 1,
//               onFieldSubmitted: (String value) {},
//             ):
// CustomPicture(path:
// field.values!.isEmpty?
// AssetsPath.SVG_number_images_image:(field.values??''),
//   isSVG:  field.values!.isEmpty,
//
//   isLocal:field.values!.isEmpty ,
//   isLocalFile: field.values!.isNotEmpty,
//   color: Styles.colorPrimary,fit: BoxFit.fitHeight,
//   width: 217.w,height: 100.h,)
//               ,
//
//             ),

            CommonSizes.vSmallerSpace,
          ];
        default:
          return [SizedBox.shrink()];
      }
    } else {
      return [SizedBox.shrink()];
    }
  }

  void _submitForm() {
    widget.listdata.forEach((element) {
      log(" ${element.name ?? ''} <==>  ${element.values ?? ''}",
          name: 'myLogs');
    });
    if (widget.formKey.currentState?.validate() ?? false) {
      // _formKey.currentState?.save();
      widget.callback(); // Notify parent widget
      //   showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(

      //       title: Text('Form Data'),
      //       content: Text(_formData.toString()),
      //       actions: [
      //         TextButton(
      //           onPressed: () => Navigator.pop(context),
      //           child: Text('OK'),
      //         ),
      //       ],
      //     ),
      //   );
    }
  }

  Future<File?> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        // Convert FilePickerResult to File
        File file = File(result.files.single.path!);
        if (Utils.isImageFile(result.files.single.path ?? ''))
          file = await _cropImage(file);
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

  final ImagePicker _picker = ImagePicker();
  File? _selectedFile;
  Map<int, FilesModelData> _selectedListFile = {};
  CroppedFile? _croppedFile;
  Future<File?> pickImageFromCamera() async {
    try {
      // Pick an image from the camera
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        File file = File(image.path);
        file = await _cropImage(file);

        return file;
      }
      return null;
    } catch (e) {
      print('Error picking file: $e');
      return null;
    }
  }

  void _showMenuWithPreview(GroupedField field) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              if (field.values!.isNotEmpty) CommonSizes.vSmallSpace,
              if (field.values!.isNotEmpty)
                buildPreviewFile(field.values ?? ''),
              if (field.values!.isNotEmpty) CommonSizes.vSmallSpace,
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('كاميرا'),
                onTap: () async {
                  Navigator.pop(context); // Close the menu

                  _selectedFile = await pickImageFromCamera();
                  saveFile(field, _selectedFile);
                  setState(() {});
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('ملفاتي'),
                onTap: () async {
                  Navigator.pop(context); // Close the menu
                  _selectedFile = await _pickFile();
                  saveFile(field, _selectedFile);
                  setState(() {});
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<File> _cropImage(File _pickedFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _pickedFile!.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio4x3,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'قص الصورة',
          toolbarColor: Styles.colorPrimary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    // if (croppedFile != null) {
    //   setState(() {
    //     _croppedFile = croppedFile;
    //   });
    // }
    return File(croppedFile!.path);
  }

  void _showMenu(GroupedField field) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('كاميرا'),
                onTap: () async {
                  Navigator.pop(context); // Close the menu

                  _selectedFile = await pickImageFromCamera();
                  saveFile(field, _selectedFile);
                  setState(() {});
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('ملفاتي'),
                onTap: () async {
                  setState(() async {
                    _selectedFile = await _pickFile();

                    saveFile(field, _selectedFile);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  buildPreviewFile(String path) {
    if (!Utils.isImageFile(path)) {
      return Container(
          height: 250.w,
          // width: 200.w,
          child: Center(child: SfPdfViewer.file(File(path)))
          // key: _pdfViewerKey,
          );
    } else {
      return CustomPicture(
        path: path,
        isSVG: false,
        isLocalFile: true,
        raduis: 8.r,
        fit: BoxFit.fill,
        height: 200.w,
        width: 200.w,
      );
    }
  }

  saveFile(GroupedField field, File? _selectedFile) async {
    int indexed = listdataShown.indexWhere((e) => e.id == field.id);
    if (_selectedFile != null) {
      listdataShown[indexed].values = _selectedFile!.path;
      final bytes = await _selectedFile.readAsBytes();

      // Convert the bytes to base64
      String base64String = base64Encode(bytes);
      _selectedListFile.addAll({
        field.id: FilesModelData(
            name: (field.name ?? '') + _selectedFile!.path.split('.').last,
            field_id: field.id.toString(),
            file: base64String)
      });
      FilesModelDataList fileToSend = FilesModelDataList(files: []);
      fileToSend.files = _selectedListFile.values.toList();
      widget.onValueSelected(fileToSend);
    }
  }
}
