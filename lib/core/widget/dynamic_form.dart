
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../features/account/data/remote/models/responses/get_field_model.dart';
import '../../l10n/locale_provider.dart';
import '../styles.dart';
import '../utils/common_sizes.dart';
import 'custom_button.dart';
import 'custom_radio_tile.dart';
import 'custom_text.dart';
import 'custom_text_field.dart';

class DynamicFormPage extends StatefulWidget {
  final List<GroupedField> listdata;
  final GlobalKey<FormState> formKey;
bool isEditeStyle;
  final VoidCallback callback;
  final VoidCallback? pickFile;

  DynamicFormPage(
      {required this.listdata,
        required this.formKey,
          this.isEditeStyle=false,
        this.pickFile,
        required this.callback});

  @override
  _DynamicFormPageState createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<DynamicFormPage> {
  final Map<String, dynamic> _formData = {}; // Store form data here

  @override
  void initState() {
    super.initState();
    _initializeFormFields();
  } // Store form data for all steps

  void _initializeFormFields() {
    for (var field in widget.listdata) {
      _formData[field.name ?? ''] = field.values; // Initialize with empty values
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      // SingleChildScrollView(
      // child:
      Padding(
        padding: const EdgeInsets.all(0.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              Expanded(child:     SingleChildScrollView(child: Column(children: [
                ...getLsitWidgte(),],),),),
              SizedBox(height: 20),
              CustomButton(
                width: double.infinity,

                text: 'التالي',

                style: Styles.w700TextStyle().copyWith(
                  fontSize: 16.sp,
                  height: 24/16,
                  color: Styles.colorTextWhite,
                ),
                raduis: 8.r,
                textAlign: TextAlign.center,
                color: Styles.colorPrimary,
                fillColor: Styles.colorPrimary,
                // width: 350.w,
                height: 54.h,
                alignmentDirectional: AlignmentDirectional.center,
                onPressed:   _submitForm,

              ),
              CommonSizes.vBigSpace ,
            ],
          ),
        ),
      );
  }

  List<Widget> l = [];

  getLsitWidgte() {
    l = [];
    int index = 0;
    widget.listdata
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
                isEditeStyle:widget.isEditeStyle,
                // width: 217.w,
                initialValue: field.values ?? "",

                isRtl: Provider.of<LocaleProvider>(context).isRTL,
                // textKey: _usernameKey,
                // controller: _usernameController,

                textInputAction: TextInputAction.next,

                keyboardType: TextInputType.text,
                validator: (value) {
                  int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);

                  widget.listdata[indexed].values = value;
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
                  int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);

                  field.values = value;
                  widget.listdata[indexed].values = value;

                  _formData[field.name ?? ''] = value;
                  //   if (_usernameKey.currentState!.validate()) {}
                  //   setState(() {});
                },
                maxLines: 1,
                onFieldSubmitted: (String value) {
                  field.values = value;
                  int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);

                  widget.listdata[indexed].values = value;

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
                isEditeStyle:widget.isEditeStyle,

                // width: 217.w,
                initialValue: field.values ?? "",

                isRtl: Provider.of<LocaleProvider>(context).isRTL,
                // textKey: _usernameKey,
                // controller: _usernameController,

                textInputAction: TextInputAction.next,

                keyboardType: TextInputType.text,
                validator: (value) {
                  // [index].values = ;
                  int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);
                  widget.listdata[indexed].values=value;
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
                  int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);
                  widget.listdata[indexed].values=value;

                  _formData[field.name ?? ''] = value;
                  //   if (_usernameKey.currentState!.validate()) {}
                  //   setState(() {});
                },
                maxLines: 1,
                onFieldSubmitted: (String value) {
                  field.values = value;
                  int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);
                  widget.listdata[indexed].values=value;
                  _formData[field.name ?? ''] = value;
                },
              ),
              CommonSizes.vSmallerSpace,
            ]);
          }
          return wdgetLst;
        case 'date':

          return  [
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
                      initialDate: DateTime(DateTime.now().year - 18,
                          DateTime.now().month,DateTime.now().day),
                      firstDate: DateTime(1901, 1),
                      lastDate: DateTime(2100));
                  if (picked != null && picked != field.values)
                    setState(() {
                      field.values = picked.toString();
                      textEditingController.value = TextEditingValue(text: picked.toString());


                      _formData[field.name ?? ''] =field.values ;
                       int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);

                      widget.listdata[indexed].values = field.values;


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
                      initialDate: DateTime(DateTime.now().year - 18,
                          DateTime.now().month,DateTime.now().day),
                      firstDate: DateTime(1901, 1),
                      lastDate: DateTime(2100));
                  if (picked != null && picked != field.values)
                    setState(() {
                      field.values = picked.toString();
                      textEditingController.value = TextEditingValue(text: picked.toString());
                    });
                  if (picked != null) {
                    // Update the controller text to show the selected date
                    // _controller.text =
                    // "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                  }
                },
                child:
                CustomTextField(
                  // height: 60.h,
                  isEditeStyle:widget.isEditeStyle,

                  // width: 217.w,
                  //  : true,
                  controller: textEditingController,
                  isRtl: Provider.of<LocaleProvider>(context).isRTL,
                  // textKey: _usernameKey,
                  // controller: _usernameController,
                  readonly: true,
                  textInputAction: TextInputAction.next,

                  keyboardType: TextInputType.text,
                  validator: (value) {
                    // [index].values = ;

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


                    _formData[field.name ?? ''] = value;
                    //   if (_usernameKey.currentState!.validate()) {}
                    //   setState(() {});
                  },
                  maxLines: 1,
                  onFieldSubmitted: (String value) {
                    field.values = value;

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
              isEditeStyle:widget.isEditeStyle,

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
          int selectedIndex=0;
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

            Container(                height: 56.h,
                child:
                DropdownButtonFormField<String>(
                  value:    field.optionsList![1],
                  decoration: InputDecoration(labelText: '',
                      contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 20.w),
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)), )),
                  items: (field.optionsList ?? [])
                      .map((option) =>
                      DropdownMenuItem(value: option, child: Text(option)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _formData[field.name ?? ''] = value;



                      field.values =value;


                      _formData[field.name ?? ''] =field.values ;
                      int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);

                      widget.listdata[indexed].values = field.values;


                    });
                  },
                  validator: (value) {
                    if ((value == null || value.isEmpty) && field.required == 1) {
                      return 'Please select ${field.name}';
                    }
                    return null;
                  },
                )),
            CommonSizes.vSmallerSpace,
          ];
        case 'checkbox':
          if( _formData[field.name ?? '']==null)
            _formData[field.name ?? '']=false;
          return [
            // CustomText(
            //   text: field.name ?? '',
            //   style: Styles.w400TextStyle()
            //       .copyWith(fontSize: 16.sp, color: Styles.colorText),
            //   alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
            //       ? Alignment.centerRight
            //       : Alignment.centerLeft,
            //   textAlign: Provider.of<LocaleProvider>(context).isRTL
            //       ? TextAlign.right
            //       : TextAlign.left,
            // ),
            CommonSizes.vSmallestSpace,
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading, // Checkbox on the right
              activeColor: Styles.colorPrimary,
              title:

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
              value:  _formData[field.name ?? ''].toString().compareTo('1')==1,
              onChanged: (value) {
                setState(() {
                  _formData[field.name ?? ''] = value;
                });
              },
            ),
            CommonSizes.vSmallerSpace,
          ];
        case 'radio':
          if(_formData[field.name ?? ''] ==null)
            _formData[field.name ?? ''] = field.optionsList![0];
          List<Widget> lst = [];
          field.optionsList!.removeWhere((e)=>e.isEmpty);

          for (int i = 0; i < field.optionsList!.length!; i++) {
            lst.add(
              CustomRadioTile(
                groupVal: i,
                val: field.optionsList!.indexWhere((e)=>e.compareTo(_formData[field.name ?? '']??'') ==0 ),
                onChange: (int value) {
                  print(value);
                  _formData[field.name ?? ''] =field.optionsList![value]??''  ;
                  print( _formData[field.name ?? '']);
                   field.values = field.optionsList![value]??'' ;
                  int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);

                  widget.listdata[indexed].values = field.values;

                   setState(() {

                  });
                },
                top: 0,
                bottom: 0,

                child:

                CustomText(
                  paddingHorizantal: 10.w,
                  text: field.optionsList![i] ?? '' ,
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
            );lst.add(
              CommonSizes.hSmallerSpace,            );
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
            ElevatedButton(
              onPressed: () async {
                widget.pickFile!(); // Notify parent widget
              },
              child: Text('Upload ${field.name}'),
            ),
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
    else{
      Fluttertoast.showToast(msg: 'check All Filed');
    }
  }
}
