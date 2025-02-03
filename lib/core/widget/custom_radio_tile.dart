import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles.dart';
import '../utils/common_sizes.dart';

class CustomRadioTile extends StatefulWidget {
  final int groupVal;
  final int val;
  final Widget child;
  final Function(int) onChange;
  final double top, bottom;
  final String? imageUrl;
  final bool isLanguage;
  final bool isCountry;
  final bool isReport;
  final bool isQuestion;

  final BoxDecoration? decoration;

  const CustomRadioTile(
      {Key? key,
      required this.groupVal,
      required this.val,
      required this.child,
      required this.onChange,
      required this.top,
      this.imageUrl,
      this.decoration,
      this.isLanguage = false,
      this.isCountry = false,
      this.isReport = false,
      this.isQuestion = false,
      required this.bottom})
      : super(key: key);

  @override
  _CustomRadioTileState createState() => _CustomRadioTileState();
}

class _CustomRadioTileState extends State<CustomRadioTile> {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 24.w,
      // width:60.w,
      // padding: EdgeInsets.only(top: widget.top == null ? 0 : widget.top,
      // bottom: widget.bottom == null ? 0 : widget.bottom),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        onTap: () {
          widget.onChange(widget.groupVal);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 24.w,
              width: 24.w,
              padding: const EdgeInsets.all(5),
              child: Radio(
                onChanged: (_) {
                  widget.onChange(widget.groupVal);
                },
                groupValue: widget.groupVal,
                value: widget.val,
                activeColor: Styles.colorPrimary,
              ),
            ),
            Container(
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }

  _onChangeCalled() {
    widget.onChange(widget.val);
  }
}
