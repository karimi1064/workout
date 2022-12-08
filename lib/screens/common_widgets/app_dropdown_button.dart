import 'package:flutter/material.dart';
import 'package:workout/core/constants/color_constants.dart';

class AppDropDownButton<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T> onChanged;
  final T value;
  final bool isEnabled;
  final bool isBorder;
  final double radius;
  final TextStyle? textStyle;
  final Color? color;
  final Color? borderColor;
  final Widget? icon;

  const AppDropDownButton({
    Key? key,
    required this.dropdownMenuItemList,
    required this.onChanged,
    required this.value,
    this.isEnabled = true,
    this.isBorder = true,
    this.radius = 4.0,
    this.textStyle,
    this.color,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  @override
  State<AppDropDownButton> createState() => _AppDropDownButtonState();
}

class _AppDropDownButtonState extends State<AppDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isEnabled,
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
            border: widget.isBorder
                ? Border.all(
              color: widget.borderColor ?? ColorConstants.textFieldBorder.withOpacity(0.4),
              width: 1,
            )
                : const Border(),
            color: widget.isEnabled
                ? (widget.color ?? ColorConstants.textFieldBackground)
                : ColorConstants.textFieldBackground),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            style: widget.textStyle ??  const TextStyle(
              color: ColorConstants.textBlack,
              fontSize: 16,
            ),
            items: widget.dropdownMenuItemList,
            onChanged: widget.onChanged,
            value: widget.value,
            elevation: 0,
            underline: const SizedBox.shrink(),
            borderRadius: BorderRadius.circular(widget.radius),
            dropdownColor: ColorConstants.textFieldBackground,
            iconEnabledColor: ColorConstants.primaryColor,
            icon: widget.icon ?? const Icon(Icons.keyboard_arrow_down_sharp),
          ),
        ),
      ),
    );
  }
}