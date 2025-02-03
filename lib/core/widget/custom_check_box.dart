import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../l10n/locale_provider.dart';
import '../styles.dart';

class CustomCheckBox extends StatefulWidget {
  final String trailer;
  final Function(bool value) onChanged;
  final bool checkBoxValue;
  final bool withWidget;
  final FocusNode? focusNode;
  final Widget? widgt;

  const CustomCheckBox(
      {Key? key,
      required this.trailer,
      required this.onChanged,
      this.withWidget = false,
      this.widgt,
      this.checkBoxValue = false,
      this.focusNode})
      : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _checkBoxValue = false;

  @override
  void initState() {
    _checkBoxValue = widget.checkBoxValue;
    super.initState();
  }

  bool isRtl = false;

  @override
  Widget build(BuildContext context) {
    isRtl = Provider.of<LocaleProvider>(context, listen: false).isRTL;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusNode:
              (widget.focusNode != null) ? widget.focusNode : FocusNode(),
          highlightColor: Colors.transparent,
          onTap: () {
            setState(
              () {
                _checkBoxValue = !_checkBoxValue;
              },
            );
            widget?.onChanged?.call(_checkBoxValue);
          },
          child: Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: _checkBoxValue ? Styles.colorPrimary : Colors.transparent,
              border: Border.all(
                color: _checkBoxValue
                    ? Styles.colorTextWhite
                    : Styles.colorBorderTextField,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: _checkBoxValue
                  ? Icon(
                      Icons.check,
                      size: 25.r,
                      color: Styles.colorTextWhite,
                    )
                  : SizedBox(),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: widget.withWidget
              ? widget.widgt!
              : Text(
                  widget.trailer,
                  style: _checkBoxValue
                      ? Styles.w400TextStyle().copyWith(
                          color: Styles.colorTextTitle, fontSize: 16.sp)
                      : Styles.w300TextStyle().copyWith(
                          color: Styles.colorTextInactive, fontSize: 16.sp),
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  softWrap: true,
                ),
        ),
      ],
    );
  }
}
