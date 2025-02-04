import 'dart:convert';
import 'dart:developer';

import 'package:chip_list/chip_list.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lebaneseEmbassy/core/constants.dart';
import 'package:lebaneseEmbassy/core/utils/common_sizes.dart';
import 'package:provider/provider.dart';

import '../../features/account/data/remote/models/responses/family_group_field.dart';
import '../../features/account/data/remote/models/responses/get_field_model.dart';
import '../../features/services/data/remote/models/params/country.dart';
import '../../l10n/locale_provider.dart';
import '../../service_locator.dart';
import '../shared_preferences_items.dart';
import '../state/appstate.dart';
import '../styles.dart';
import 'custom_text.dart';

class SelectFieldProcessor {
  Widget buildSelectField(
    BuildContext context,
    GroupedField field,
    Map<String, dynamic> formData,
    List<dynamic> listdataShown,
    Function(Function()) setState,
  ) {
    if (field.options!.contains('family')) {
      return _buildFamilySelectionWidget(
          context, field, formData, listdataShown, setState);
    }
    if (field.options!.contains('بلدان')) {
      return _buildCountrySelectionWidget(
          context, field, formData, listdataShown, setState);
    }
    return _buildGenericSelectionWidget(
        context, field, formData, listdataShown, setState);
  }

  Widget _buildFamilySelectionWidget(
    BuildContext context,
    GroupedField field,
    Map<String, dynamic> formData,
    List<dynamic> listdataShown,
    Function(Function()) setState,
  ) {
    final familyData = _extractFamilyData(field);
    // log("familyData: ${familyData?.groupedFields}",name: 'family logs');
    // if (familyData == null) return const SizedBox.shrink();


    field.optionsList = familyData;
    // log("field.optionsList: ${field.optionsList}",name: 'family logs');


    return _createChipSelectionWidget(
      context: context,
      field: field,
      formData: formData,
      listdataShown: listdataShown,
      setState: setState,
    );
  }

  Widget _buildCountrySelectionWidget(
    BuildContext context,
    GroupedField field,
    Map<String, dynamic> formData,
    List<dynamic> listdataShown,
    Function(Function()) setState,
  ) {
    final countryOptions = _loadCountryOptions();
    final selectedCountry =
        _determineSelectedCountry(countryOptions, formData, field);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createFieldLabel(context, field),
        CommonSizes.vSmallestSpace,
        _createCountryDropdown(
          countryOptions: countryOptions,
          selectedCountry: selectedCountry,
          field: field,
          formData: formData,
          listdataShown: listdataShown,

          setState: setState,
        ),
      ],
    );
  }

  Widget _buildGenericSelectionWidget(
    BuildContext context,
    GroupedField field,
    Map<String, dynamic> formData,
    List<dynamic> listdataShown,
    Function(Function()) setState,
  ) {
    field.optionsList = _parseFieldOptions(field.options);

    if (field.optionsList!.isEmpty) return const SizedBox.shrink();

    return _handleOptionSelection(
      context: context,
      field: field,
      formData: formData,
      listdataShown: listdataShown,
      setState: setState,
    );
  }

  Widget _handleOptionSelection({
    required BuildContext context,
    required GroupedField field,
    required Map<String, dynamic> formData,
    required List<dynamic> listdataShown,
    required Function(Function()) setState,
  }) {
    if (_hasParentheticalOptions(field.optionsList!)) {
      return _buildParentheticalSelectionWidget(
        context: context,
        field: field,
        formData: formData,
        listdataShown: listdataShown,
        setState: setState,
      );
    }

    return _createChipSelectionWidget(
      context: context,
      field: field,
      formData: formData,
      listdataShown: listdataShown,
      setState: setState,
    );
  }

  // Helper methods (to be implemented)
  List<String> _extractFamilyData(GroupedField field) {
    final familyData = sl<AppStateModel>()
        .prefs
        .getString(SharedPreferencesKeys.USER_Family_Data);


    if (familyData == null || familyData.isEmpty || familyData == 'null') {
      return [];
    }

    try {
      final familyGroupField =
          FamilyGroupField.fromJson(jsonDecode(familyData));
      final personalNames = <String>[];

      for (var groupKey in familyGroupField.groups) {
        final groupFields = familyGroupField.groupedFields[groupKey];
        if (groupFields != null) {
          final personalNameField = groupFields.firstWhere(
            (field) => field.name == 'الاسم الشخصي',
            //  orElse: () => GroupedField(values: ''),
          );
          if (personalNameField.values != null) {
            personalNames.add(personalNameField.values!);
          }
        }
      }

      return personalNames;
    } catch (e) {
      return [];
    }
  }

  List<CountryModel> _loadCountryOptions() {
    final json = jsonDecode(countryJsonData);
    return json != null
        ? (json as List).map((v) => CountryModel.fromJson(v)).toList()
        : [];
  }

  CountryModel _determineSelectedCountry(
    List<CountryModel> countryOptions,
    Map<String, dynamic> formData,
    GroupedField field,
  ) {
    final selectedName = formData[field.name] ?? '';
    return countryOptions.firstWhere(
      (country) => country.name == selectedName,
      orElse: () => countryOptions.first,
    );
  }

  List<String> _parseFieldOptions(String? options) {
    return options
            ?.split('،')
            .map((option) => option.trim())
            .where((option) => option.isNotEmpty)
            .toList() ??
        [];
  }

  Widget _createChipSelectionWidget({
    required BuildContext context,
    required GroupedField field,
    required Map<String, dynamic> formData,
    required List<dynamic> listdataShown,
    required Function(Function()) setState,
  }) {
    final options = field.optionsList ?? [];
    final currentValue = formData[field.name];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createFieldLabel(context, field),
        ChipList(
          listOfChipNames: options.map((option) => option ?? '').toList(),
          activeTextColorList: [Styles.colorTextWhite],
          activeBgColorList: [Styles.colorPrimary],
          inactiveBgColorList: [Styles.colorbtnGray.withOpacity(0.5)],
          shouldWrap: true,
          showCheckmark: false,
          style: Styles.w700TextStyle()
              .copyWith(color: Styles.colorTextWhite, fontSize: 16.sp),
          runSpacing: 8.w,
          spacing: 8.w,
          inactiveTextColorList: [Styles.colorIconInActive],
          listOfChipIndicesCurrentlySelected:
              currentValue != null ? [options.indexOf(currentValue)] : [],
          extraOnToggle: (currentIndex) {
            setState(() {
              final selectedValue = options[currentIndex];
              final fieldIndex =
                  listdataShown.indexWhere((e) => e.id == field.id);

              listdataShown[fieldIndex].values = selectedValue;
              formData[field.name!] = selectedValue;
            });
          },
        ),
      ],
    );
  }

  Widget _createFieldLabel(BuildContext context, GroupedField field) {
    return CustomText(
      text: field.name ?? '',
      style: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorText),
      alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
          ? Alignment.centerRight
          : Alignment.centerLeft,
      textAlign: Provider.of<LocaleProvider>(context).isRTL
          ? TextAlign.right
          : TextAlign.left,
    );
  }

  bool _hasParentheticalOptions(List<String> options) {
    return options
        .any((option) => option.contains('(') && option.contains(')'));
  }

  List<String> _extractOptionsWithParentheses(List<String> options) {
    final RegExp outsidePattern = RegExp(r"(.*?)(?=\()");
    final RegExp insidePattern = RegExp(r"\((.*?)\)");

    return options
        .map((option) {
          final outsideMatch = outsidePattern.firstMatch(option);
          final insideMatch = insidePattern.firstMatch(option);

          return outsideMatch != null
              ? outsideMatch.group(1)?.trim() ?? ''
              : '';
        })
        .where((text) => text.isNotEmpty)
        .toList();
  }

  List<String> _extractParentheticalExplanations(List<String> options) {
    final RegExp insidePattern = RegExp(r"\((.*?)\)");

    return options
        .map((option) {
          final insideMatch = insidePattern.firstMatch(option);
          return insideMatch != null ? insideMatch.group(1)?.trim() ?? '' : '';
        })
        .where((text) => text.isNotEmpty)
        .toList();
  }

  Widget _createCountryDropdown({
    required List<CountryModel> countryOptions,
    required CountryModel selectedCountry,
    required GroupedField field,
    required Map<String, dynamic> formData,
    required List<dynamic> listdataShown,
    required Function(Function()) setState,
  }) {
    return DropdownButtonFormField<CountryModel>(
      value: selectedCountry,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
    

        ),
      ),

      items: countryOptions
          .map((country) => DropdownMenuItem(
                value: country,
                child: Row(
                  children: [
                    _buildCountryFlag(country),
                    CommonSizes.hSmallestSpace,
                    Text(country.name)
                  ],
                ),
              ))
          .toList(),
      onChanged: (selectedCountry) {
        setState(() {
          final fieldIndex = listdataShown.indexWhere((e) => e.id == field.id);
          listdataShown[fieldIndex].values = selectedCountry!.name;
          formData[field.name!] = selectedCountry.name;
        });
      },
      validator: (value) => value == null && field.required == 1
          ? 'Please select ${field.name}'
          : null,
    );
  }

  Widget _buildCountryFlag(CountryModel country) {
    return Container(
      width: 20.w,
      height: 20.w,
      child: FittedBox(
        fit: BoxFit.fill,
        child: CountryFlag.fromCountryCode(
          country.code,
          width: 20.w,
          height: 20.w,
        ),
      ),
    );
  }

  Widget _buildParentheticalSelectionWidget({
    required BuildContext context,
    required GroupedField field,
    required Map<String, dynamic> formData,
    required List<dynamic> listdataShown,
    required Function(Function()) setState,
  }) {
    final List<String> mainOptions =
        _extractOptionsWithParentheses(field.optionsList!);
    final List<String> explanations =
        _extractParentheticalExplanations(field.optionsList!);

    int selectedIndex = mainOptions.indexOf(formData[field.name] ?? '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createFieldLabel(context, field),
        ChipList(
          listOfChipNames: mainOptions,
          activeTextColorList: [Styles.colorTextWhite],
          activeBgColorList: [Styles.colorPrimary],
          inactiveBgColorList: [Styles.colorbtnGray.withOpacity(0.5)],
          shouldWrap: true,
          showCheckmark: false,
          style: Styles.w700TextStyle()
              .copyWith(color: Styles.colorTextWhite, fontSize: 16.sp),
          listOfChipIndicesCurrentlySelected:
              selectedIndex != -1 ? [selectedIndex] : [],
          extraOnToggle: (currentIndex) {
            setState(() {
              final selectedValue = mainOptions[currentIndex];
              final fieldIndex =
                  listdataShown.indexWhere((e) => e.id == field.id);

              listdataShown[fieldIndex].values = selectedValue;
              formData[field.name!] = selectedValue;
            });
          },
        ),
        if (selectedIndex != -1)
          CustomText(
            text: explanations[selectedIndex],
            style: Styles.w400TextStyle()
                .copyWith(fontSize: 16.sp, color: Styles.colorTextError),
          ),
      ],
    );
  }
}
