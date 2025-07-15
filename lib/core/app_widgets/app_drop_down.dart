import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';

class AppDropDown<T> extends StatefulWidget {
  final List<T> options;
  final T? initialValue;
  final String? label;
  final String Function(T)? getLabel;
  final Color? dropdownLabelColor;
  final Color? borderColor;
  final Color? fillColor;
  final bool? isOptional;
  final bool isEnabled;
  final double? width;
  final double? height;
  final double? borderRadius;
  final ValueChanged<T?>? onChange;
  final FocusNode? focusNode;
  final bool enableSearch;
  final String? hintText;

  const AppDropDown({
    super.key,
    required this.options,
    required this.getLabel,
    this.initialValue,
    this.label,
    this.dropdownLabelColor,
    this.borderColor,
    this.fillColor,
    this.isOptional = false,
    this.isEnabled = true,
    this.width,
    this.height,
    this.borderRadius,
    this.onChange,
    this.focusNode,
    this.enableSearch = false,
    this.hintText,
  });

  @override
  State<AppDropDown<T>> createState() => _AppDropDownState<T>();
}

class _AppDropDownState<T> extends State<AppDropDown<T>> {
  late T? selectedValue;

  @override
  void initState() {
    selectedValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = StyleManager.getRegularStyle(
      color: ColorManager.blackColor,
      fontSize: 14,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              children: [
                Text(widget.label!, style: labelStyle),
                const SizedBox(width: 10),
                if (widget.isOptional!)
                  Text("(اختياري)", style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (_) => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: BoxDecoration(
              color: widget.fillColor ?? ColorManager.colorWhite1,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
              border: Border.all(color: widget.borderColor ?? Colors.transparent),
            ),
            child: DropdownButtonFormField<T>(
              value: selectedValue,
              isExpanded: true,
              iconEnabledColor: ColorManager.grey,
              decoration: InputDecoration(
                hintText: widget.hintText ?? 'اختر',
                hintStyle: const TextStyle(fontFamily: FontConstants.fontTajawal),
                labelStyle: const TextStyle(fontFamily: FontConstants.fontTajawal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
                  borderSide: const BorderSide(color: ColorManager.colorWhite1, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
                  borderSide: const BorderSide(color: ColorManager.colorWhite1, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
                  borderSide: BorderSide(color: widget.borderColor ?? ColorManager.colorWhite1, width: 1),
                ),
                contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 22),
              ),
              dropdownColor: ColorManager.colorWhite1,
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: widget.borderColor != null ? Colors.black : null),
              menuMaxHeight: MediaQuery.sizeOf(context).height * 0.45,
              items: widget.options.map((T item) {
                final label = widget.getLabel?.call(item) ?? item.toString();
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    label,
                    style: StyleManager.getRegularStyle(
                      color: selectedValue == item
                          ? ColorManager.blackColor
                          : ColorManager.greyHint,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
              selectedItemBuilder: (_) {
                return widget.options.map((T item) {
                  final label = widget.getLabel?.call(item) ?? item.toString();
                  return Text(label);
                }).toList();
              },
              onChanged: widget.isEnabled
                  ? (value) {
                setState(() {
                  selectedValue = value;
                });
                if (widget.onChange != null) {
                  widget.onChange!(value);
                }
              }
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
