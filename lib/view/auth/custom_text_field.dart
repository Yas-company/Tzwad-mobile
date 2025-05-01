import 'package:flutter/material.dart';
import '../../view/utils/constant_colors.dart';

class CustomTextField extends StatefulWidget {
  final String levelText;
  String? leadingImage;
  bool trailing;
  bool obscureText;
  TextEditingController? controller;
  void Function(String)? onFieldSubmitted;
  String? Function(String?)? validator;
  FocusNode? focusNode;
  void Function(String?)? onSaved;
  void Function(String)? onChanged;
  String? initialValue;
  TextInputType? keyboardType;
  @override
  Key? key;
  CustomTextField(
    this.levelText, {
    this.controller,
    this.leadingImage,
    this.trailing = false,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.validator,
    this.focusNode,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.keyboardType,
    this.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      key: widget.key,
      keyboardType: widget.keyboardType,
      // focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: widget.obscureText,
      // autovalidateMode: AutovalidateMode.always,
      style:
          TextStyle(color: ConstantColors().greyTextFieldLebel, fontSize: 13),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 17),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: ConstantColors().primaryColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ConstantColors().greyBorder, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ConstantColors().orange, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ConstantColors().orange, width: 1),
        ),
        hintText: widget.levelText,

        hintStyle:
            TextStyle(color: ConstantColors().greyTextFieldLebel, fontSize: 13),

        prefixIcon: widget.leadingImage != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 25,
                      child: Image.asset(
                        widget.leadingImage!,
                      )),
                ],
              )
            : null,
        suffixIcon: widget.trailing
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    },
                    child: SizedBox(
                      height: 23,
                      child: widget.obscureText
                          ? Image.asset(
                              'assets/images/icons/pass_hide.png',
                              fit: BoxFit.fitHeight,
                            )
                          : Icon(
                              Icons.remove_red_eye_rounded,
                              color: ConstantColors().primaryColor,
                            ),
                    ),
                  ),
                ],
              )
            : null,

        //  if (leadingImage != null)?
      ),
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator == null ? null : (_) => widget.validator!(_),
      onSaved: widget.onSaved == null ? null : (_) => widget.onSaved!(_),
      onChanged: widget.onChanged == null ? null : (_) => widget.onChanged!(_),
      onEditingComplete: () => FocusScope.of(context).unfocus(),
    );
  }
}
